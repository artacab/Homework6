trigger AccountUpdAdress on Account (after update) {
    	
		Set<Id> setAccountAddressChangedIds = new Set<Id>();
		for (Account oAccount : trigger.new) {
			Account oOldAccount = trigger.oldMap.get(oAccount.Id);
			if (oAccount.BillingCity != oOldAccount.BillingCity || oAccount.BillingStreet != oOldAccount.BillingStreet || oAccount.BillingState != oOldAccount.BillingState || oAccount.BillingCountry != oOldAccount.BillingCountry || oAccount.BillingPostalCode != oOldAccount.BillingPostalCode) {
				setAccountAddressChangedIds.add(oAccount.Id);
			}
		}
    	AccountTriggerHandler.updateContactSync(setAccountAddressChangedIds);
    	AccountTriggerHandler.updateWithQueueable(setAccountAddressChangedIds);
    	AccountSchedule m = new AccountSchedule();
    	String sch = '0 30 * * * ?';
    	String jobID = system.schedule('test', sch, m);
}