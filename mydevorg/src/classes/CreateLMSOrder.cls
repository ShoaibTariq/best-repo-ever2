/**
 * Author: Creation Technology
 * Date: 18/09/2018
 * Description: 
 */
@RestResource(urlMapping='/createOrder/*')
global class CreateLMSOrder {
    /**
     * [doPost -Used to insert records into salesforce from external]
     * @return [CreateOrderParser]
     */
    @HttpPost
    global static CreateOrderParser doPost() 
    { 
        RestRequest     request    = RestContext.request;
        RestResponse    response   = RestContext.response;    
        response.addHeader('Content-Type','applicatin/json');

        CreateOrderParser jsonBody ;
        try
        {
            jsonBody  = (CreateOrderParser) JSON.deserialize(request.requestBody.toString(),CreateOrderParser.class);
        }
        Catch(Exception ex)
        {
            System.debug('errorMessage' +ex.getMessage());
        }
        AccountQueueable newAccountQueueable = new AccountQueueable(jsonBody);
        System.enqueueJob(newAccountQueueable);
        
        return jsonBody;
    }
}