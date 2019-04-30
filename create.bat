

##create folder and project
##gcloud alpha resource-manager folders create --display-name=$FOLDER
gcloud projects create $PROJECT_ID --folder=$FOLDER
gcloud projects describe  $PROJECT_ID
gcloud beta billing projects link $PROJECT_ID --billing-account=$BILLING_ID


#allow usage with python pandas
pip install --upgrade google-cloud-bigquery[pandas] --user
pip install --upgrade google-cloud-bigquery-storage[fastavro,pandas] --user



#set up cloud storage
# directory structure

# raw/x
gsutil mb -l $REGION gs://$PROJECT_ID"-raw"/

#test load a file with numbers and text and load it into cloud storage from the local cloud shell file system
#Get the file
wget https://raw.githubusercontent.com/fivethirtyeight/data/master/hip-hop-candidate-lyrics/genius_hip_hop_lyrics.csv


#rename it to a GCP/BQ friendly format i.e get rid of periods (not sure this is needed - need to get rid of the CSV element to turn it into a raw name
mv genius_hip_hop_lyrics.csv genius_hip_hop_lyrics-csv #need to change this to an automated one at some point 


TESTFILE=genius_hip_hop_lyrics.csv 
TESTTABLE=genius_hip_hop_lyrics 
gsutil cp $TESTFILE gs://$PROJECT_ID"-raw"/


# stand/x in bigquery



bq rm $L1
bq rm $L2
bq rm $L1
bq --location=$REGION mk --dataset  --description "landing area for staging data on the way into big query from cloud storage" $PROJECT_ID:$L1
bq mk $L2
mkdir $L1


#grant bigquery.jobs.create 
#grant load into new or existing BQ tables/particiones

#load the test table into the landing area
bq --location=$REGION load --autodetect --source_format=CSV $L1.$TESTTABLE gs://$PROJECT_ID"-raw"/$TESTFILE
bq --location=$REGION load --source_format=NEWLINE_DELIMITED_JSON  $L1.SRCMGT $L1/$SRCTGT.json

bq show --schema --format=prettyjson $PROJECT_ID:$L1.$TESTTABLE > $L1/$TESTTABLE.json
#bq rm --table --f $L1.$SRCTGT
bq --location=$REGION mk --table $PROJECT_ID:$L1.$SRCMGT $SRCMGT.json
bq --location=$REGION show --schema --format=prettyjson --table $PROJECT_ID:$L1.$SRCTGT





bq update --description "staging and add audit fields for "$TESTTABLE $PROJECT_ID:$L1.$TESTTABLE 
bq update $PROJECT_ID:$L1.$TESTTABLE $L1-$TESTTABLE.json

bq --location=$REGION query --use_legacy_sql=false 'update $PROJECT_ID:$L1.$TESTTABLE set load_date=current_date, load_user=$USER, project_ID=$PROJECT_ID, staging_layer=$L1 where load_date is null;'


land-genius_hip_hop_lyrics.json


# conformed/x



#load a test file into cloud storage

#set up standardised layer


#delete projects
gcloud projects delete $PROJECT_ID
