import json
import os

st = open('sourcetarget.json','r')

def selectStatement(st):
#with open('sourcetarget.json','r') as st:    
    #type(st)
    selectsql='select \n'
    totableset=set()
    fromtableset=set()
    for line in st:
        line_json = json.loads(line)
        #print('st is ' + str(type(st))) 
        #print('line is ' + str(type(line)))
        #print('line_json is ' + str(type(line_json)))
        #print(line_json)
        fromtable=''.join([line_json['sourcedataset'], '.', line_json['sourcetablename']])
        totable = ''.join([line_json['targetdataset'], '.', line_json['targettablename']])
        fromtableset.add(fromtable)
        totableset.add(totable)
        #print(fromtableset)
        #print(totableset)


        
        linesql=''.join([line_json['sourcedataset'],'.'\
              ,line_json['sourcetablename'],'.'\
              ,line_json['sourcefieldname']\
              ,' as '\
              ,line_json['targetdataset'],'.'\
              , line_json['targettablename'],'.'\
              ,line_json['targetfieldname'],'\n'])
        #print(linesql)
        selectsql+=''.join([('' if selectsql=='select \n' else',' ),linesql])
    fromtablelist=sorted(fromtableset) 
    selectsql+=''.join(['from ', fromtablelist[0]])
    
    print(selectsql)



selectStatement(st)


#def sourceTableList
with open('sourcetarget.json','r') as st:    
    #type(st)
    selectsql='select \n'
    totableset=set()
    fromtableset=set()
    for line in st:
        line_json = json.loads(line)
        fromtable=''.join([line_json['sourcedataset'], '.', line_json['sourcetablename']])
        totable = ''.join([line_json['targetdataset'], '.', line_json['targettablename']])
        fromtableset.add(fromtable)
        totableset.add(totable)
    
    #
    # 
    # Create and run a SQL script from layer 1 into layer 2 for each table in sourcetarget.json
    # 
    #
    #
#def tableControl
    fromTableList=sorted(fromtableset)
    for table in fromTableList:
        print(table)
        selectsql='select \n'
        st.seek(0)
        for line in st:
            line_json = json.loads(line)            
            fromtable=''.join([line_json['sourcedataset'], '.', line_json['sourcetablename']])
            #print(fromtable)
            #print(table)
            if fromtable==table:
                #print('yes')
                linesql=''.join([line_json['sourcedataset'],'.'\
                    ,line_json['sourcetablename'],'.'\
                    ,line_json['sourcefieldname']\
                    ,' as '\
                    ,line_json['targetdataset'],'.'\
                    , line_json['targettablename'],'.'\
                    ,line_json['targetfieldname'],'\n'])                
            selectsql+=''.join([('' if selectsql=='select \n' else',' ),linesql])
            #print(selectsql)
        selectsql+=''.join(['from ', table])
    
    print(selectsql)



                linesql=''.join([line_json['sourcedataset'],'.'\
                    ,line_json['sourcetablename'],'.'\
                    ,line_json['sourcefieldname']\
                    ,' as '\
                    ,line_json['targetdataset'],'.'\
                    , line_json['targettablename'],'.'\
                    ,line_json['targetfieldname'],'\n'])


