trigger PreventDuplicateEmailOnContact on Contact (before insert) {
// prevent duplicate email on the contact object
    if(trigger.isBefore && trigger.isinsert){
        set<string> newEmailsList = new set<string>();
        for(contact con:trigger.new){
           newEmailslist.add(con.Email);
        }
        set<string> oldemail= new set<string>();
        
        List<contact> conlist=[select id,lastname,email from contact where email in:newEmailsList];
        
        for(contact co:conlist){
            oldemail.add(co.Email);
        }
        for(contact cont:trigger.new){
            if(oldemail.contains(cont.email)){
                cont.adderror('this is duplicate email');
            }
        }
    } 
}