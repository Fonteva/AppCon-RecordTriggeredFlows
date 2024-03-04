public class SalesOrderService_Record_Triggered_Flow {

    @InvocableMethod(label='Apply Discount & Override order tax lines'
            description='Apply discount, update overAllTotal, Balance Due and Override order tax lines')
    public static List<ReturnVariable> updateItemsInOrder(List<InputVariable> inputParams) {
        List<OrderApi__Sales_Order_Line__c> parentLines = inputParams.get(0).parentLines;
        FDService.SalesOrderLine[] salesOrderLines = FDService.SalesOrderLine.getInstance(parentLines);

        // Execute the OrderService to update the items in Order.
        FDService.OrderService.getInstance().updateItemsInOrder(salesOrderLines);
        return new List<ReturnVariable>();
    }

    public class InputVariable {
        @InvocableVariable
        public List<OrderApi__Sales_Order_Line__c> parentLines;

    }

    public class ReturnVariable {
        @InvocableVariable
        public List<OrderApi__Sales_Order_Line__c> parentLines = new List<OrderApi__Sales_Order_Line__c>();

        public ReturnVariable(List<FDService.SalesOrderLine> lines) {
            for (FDService.SalesOrderLine line : lines) {
                this.parentLines.add((OrderApi__Sales_Order_Line__c)line.toSObject());
            }
        }
    }

}