global class AA_UploadProcessingBatchable implements Database.Batchable<sObject>, Database.Stateful{
    
    global list<Account> toProcess;
    global ID documentID;
	
	global Iterable<sObject> start(Database.BatchableContext info){
        return toProcess;
    	}
    
    global AA_UploadProcessingBatchable(list<ID> lst, Id idContentDocument){
        documentID = idContentDocument;
        list<Account> toSearch = new list<Account>();

    	toProcess = toSearch;
    	}
    	
    global void execute(Database.BatchableContext info, List<Account> scope){
        /*set<Account> cleanAccs = new set<Account>();
        list<Account> toUpdate = new list<Account>();
        for(Account a: scope){
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
                            }*/
        }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    	}
}
