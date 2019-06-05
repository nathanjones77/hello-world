
PROJECT_ID=nathan-project-1
FOLDER=Test
REGION=europe-west6
#staging names
L1=land
L2=standardised
L3=conformed
SRCMGT=aschema
SRCTGT=sourcetarget
BUCKET=$PROJECT_ID"-raw"



echo $FOLDER
echo $PROJECT_ID
echo $PROJECT_ID"-raw"

##get the billing information
#gcloud beta billing accounts list 
BILLING_ID=01D987-A6DE96-62A98D
TESTFILE=genius_hip_hop_lyrics.csv


echo $FOLDER
echo $PROJECT_ID
echo $PROJECT_ID"-raw"
echo $BILLING_ID
echo $TESTFILE
echo $L1

