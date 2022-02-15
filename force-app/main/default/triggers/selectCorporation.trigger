trigger selectCorporation on Corporation__c (before update) {
	Trigger_toogle__c cs = Trigger_toogle__c.getValues('ConTrigger');
    Shop__c [] shops = [Select id from Shop__c WHERE Corporation__c IN: Trigger.new];
    if(cs.Active__c == true) { 
        for(Shop__c sh : shops) {
            sh.Status__c = true;
        }
        cs.Active__c = false;
    	update cs;
        update shops;
    }
}