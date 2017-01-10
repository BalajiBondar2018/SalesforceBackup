public with sharing class CustomerPurchaseOrder1 implements IPurchaseorder{
	public Double discount(){
	//Customer specific logic in the discount
	Set<String> s1 = new Set<String>{'a', 'b + c'}; // Defines a new set with two elements
	return 0.5;
	}
}