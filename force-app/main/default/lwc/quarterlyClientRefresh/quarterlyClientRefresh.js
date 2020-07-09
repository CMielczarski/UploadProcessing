import { LightningElement, api} from 'lwc';

import processClientRefresh from '@salesforce/apex/AA_UploadProcessing.processClientRefresh';
import getRecord from '@salesforce/apex/AA_UploadProcessing.getRecord';

export default class QuarterlyClientRefresh extends LightningElement {

    @api acceptedFormats = '.csv'
    @api Spinner = false;
    @api recordId;

        connectedCallback(){
            console.log('Connected');
            getRecord()
                .then(
                    result=>{
                        console.log('Result: ' + result);
                        this.recordId = result;
                        }
                    )
                .catch(
                    error=>{
                        console.log('Error finding a record.' + error.message);
                    }
                );
            }
    
        handleUploadFinished(event){
            this.Spinner = true;
            const uploadedFiles = event.detail.files;
            processClientRefresh(
                            {idContentDocument : uploadedFiles[0].documentId
                            }
                         )
                .then(result => {
                    this.Spinner = false;
                    alert(result);
                    })
            .catch(error => {
                    this.Spinner = false;
                    alert(error.message);
                    });
            }
    
}