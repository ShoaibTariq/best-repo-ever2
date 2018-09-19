/**
 * @name orderTrigger
 * @description
**/
trigger orderTrigger on Order (after update,before delete,after delete) {
    if(trigger.isAfter && Trigger.isUpdate) {
        OrderHelper.afterUpdate(Trigger.new,Trigger.old);
    }
}