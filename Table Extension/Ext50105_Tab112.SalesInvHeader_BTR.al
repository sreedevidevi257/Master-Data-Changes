tableextension 50105 "Bank Sales Invoice Header" extends "Sales Invoice HEader"
{
    fields
    {
        field(50100;"Use Bank Account";Text[50])
        {
            TableRelation = "Additional Bank Account"."Bank Name";
            Editable = false;
        }
    }
    var         
    MaxAllowedValueIs100Err: Label 'The values must be less than or equal 100.';    
}