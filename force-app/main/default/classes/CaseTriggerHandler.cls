
public with sharing class CaseTriggerHandler extends TriggerHandler{
        private List<Case> newList;
        private Map<Id, Case> oldMap;

        public CaseTriggerHandler() {
        newList = (List<Case>) Trigger.new;
        oldMap = (Map<Id, Case>) Trigger.oldMap;
    }

    protected override void beforeInsert() {
        CaseTriggerHelper.checkReservation(newList);
    }
    protected override void beforeUpdate() {
        CaseTriggerHelper.notifyForReservation(newList, oldMap);
    }
}