global class TaxService extends FDService.TaxService {

    public override List<FDService.SalesOrderLine> configureTaxes(
            List<FDService.SalesOrderLine> records,
            Boolean refreshTaxes,
            Map<Id,FDService.SalesOrderLine> oldMap) {
        List<FDService.SalesOrderLine> taxLines = new List<FDService.SalesOrderLine>();
        Id salesOrderId = records[0].salesOrder;
        // Set the tax discount
        if (refreshTaxes != null & refreshTaxes == false) {
            for (FDService.SalesOrderLine parentLine : records) {
                if (parentLine != null && parentLine.salesOrderLine == null) {
                    OrderApi__Sales_Order_Line__c stateTaxLine = new OrderApi__Sales_Order_Line__c(); // State Tax
                    stateTaxLine.OrderApi__Sale_Price__c = parentLine.salePrice * 0.25;
                    stateTaxLine.OrderApi__Tax_Percent__c = 25;
                    stateTaxLine.OrderApi__Is_Tax__c = true;
                    stateTaxLine.OrderApi__Price_Override__c = true;
                    stateTaxLine.OrderApi__Item__c = 'a1INq000000TJhD';
                    stateTaxLine.OrderApi__Sales_Order_Line__c = parentLine.id;
                    stateTaxLine.OrderApi__Sales_Order__c = salesOrderId;
                    taxLines.add(FDService.SalesOrderLine.getInstance(stateTaxLine));

                    OrderApi__Sales_Order_Line__c cityTaxLine = new OrderApi__Sales_Order_Line__c(); // City Tax
                    cityTaxLine.OrderApi__Sale_Price__c = parentLine.salePrice * 0.01;
                    cityTaxLine.OrderApi__Tax_Percent__c = 1;
                    cityTaxLine.OrderApi__Is_Tax__c = true;
                    cityTaxLine.OrderApi__Price_Override__c = true;
                    cityTaxLine.OrderApi__Item__c = 'a1INq000000ZFH7';
                    cityTaxLine.OrderApi__Sales_Order_Line__c = parentLine.id;
                    cityTaxLine.OrderApi__Sales_Order__c = salesOrderId;
                    taxLines.add(FDService.SalesOrderLine.getInstance(cityTaxLine));
                }
            }
        }
        return taxLines;
    }
}