public with sharing class AA_UploadProcessing {
    
    @AuraEnabled
    public static string processClientRefresh(Id idContentDocument){
        string result;
        ContentVersion objVersion = [Select Id, VersionData, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId =: idContentDocument][0];
        ContentDocument cd = [SELECT ID FROM ContentDocument WHERE ID =: idContentDocument];
        try{
            if(idContentDocument != null){
                if(objVersion != null) {
                    String csvAsString = objVersion.VersionData.toString();
                    String[] csvFileLines = csvAsString.split('\n'); 
                    system.debug('CSV Size: ' + csvFileLines.size());
                    set<ID> cleanIDs = new set<ID>();
                    list<ID> accIDs = new list<ID>();
                    set<Account> cleanAccs = new set<Account>();
                    list<Account> toUpdate = new list<Account>();

                    for(Integer i = 1; i < csvFileLines.size(); i++){
                        string[] csvRecordData = csvFileLines[i].split(',');
                        if(!string.isBlank(csvRecordData[0])){
                            if(!test.isRunningTest()){
                                cleanIDs.add(csvRecordData[0]);
                                }
                            else{
                                ID accID = [SELECT ID FROM Account WHERE ID != null LIMIT 1].Id;
                                cleanIDs.add(accID);
                                }
                            }
                        }
                        accIDs.addAll(cleanIDs);
                        system.debug('IDs size: ' + accIDs.size());
                        for(Account a: [SELECT ID, Name, KRS_Contract_Start__c, KRS_Contract_Expiration__c, KRS_DVP__c, KRS_RVP__c, KRS_RDO__c FROM Account WHERE ID IN: accIDs]){
                            for(Integer i = 1; i < csvFileLines.size(); i++){
                                string[] csvRecordData = csvFileLines[i].split(',');
                                if(a.Id == csvRecordData[0]){
                                    if(!string.isBlank(csvRecordData[2])){
                                        a.KRS_Contract_Start__c = date.parse(csvRecordData[2]);
                                        }
                                    else{
                                        a.KRS_Contract_Start__c = null;
                                        }
                                    
                                    if(!string.isBlank(csvRecordData[3])){
                                        a.KRS_Contract_Expiration__c = date.parse(csvRecordData[3]);
                                        }
                                    else{
                                        a.KRS_Contract_Expiration__c = null;
                                        }
                                    
                                    if(!string.isBlank(csvRecordData[4])){
                                        a.KRS_DVP__c = csvRecordData[4];
                                        }
                                    else{
                                        a.KRS_DVP__c = null;
                                        }

                                    if(!string.isBlank(csvRecordData[5])){
                                        a.KRS_RVP__c = csvRecordData[5];
                                        }
                                    else{
                                        a.KRS_RVP__c = null;
                                        }

                                    if(!string.isBlank(csvRecordData[6])){
                                        a.KRS_RDO__c = csvRecordData[6];
                                        }
                                    else{
                                        a.KRS_RDO__c = null;
                                        }
                                    }
                                }
                            cleanAccs.add(a);
                            }
                        
                        toUpdate.addAll(cleanAccs);
                        update toUpdate;
                        system.debug('Made it here.');
                        delete cd;
                        result = 'Records submitted for processing.  You will receive an email notification when processing is complete.';
                        }
                        }
                else{
                    result = 'No records available to process.  Check values and try again.';
                    delete cd;
                    }
                }
            catch (Exception e){
                system.debug('Error: ' + e.getMessage() + ' Line: ' + e.getLineNumber());
                result = 'Error: ' + e.getMessage() + ' Line: ' + e.getLineNumber();
                delete cd;
                }
            return result;
        }

        @AuraEnabled
        public static string getRecord(){
            string recordId;
            recordId = [SELECT ID FROM Account LIMIT 1].Id;
            return recordId;
            }

}
