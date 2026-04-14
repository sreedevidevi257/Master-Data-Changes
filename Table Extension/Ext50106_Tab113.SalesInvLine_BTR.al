tableextension 50106 Ext50106_SalesInvLine_BTR extends "Sales Invoice Line"
{
    fields
    {
        field(50100; "HIP Code"; Code[20])
        {
            Editable = False;
        }
        field(50101; Brand; Code[10])
        {
            Editable = False;
        }
         field(50102;Origin;Code[10])
        {
            Editable = False;            
        }
        field(50103;"Manufacturer Code";Code[20])
        {            
            Editable = False;            
        }
        field(50104;"HS Code";Code[20])
        {            
            Editable = False;            
        }
        field(50125;"Cust. Ref #";Text[20])
        {            
        }
        field(50128;"Item Category PGR 1";Code[50])
        {    
        }
        field(50129;"Item Category PGR 2";Code[50])
        {
        }
        field(50130;"Item Category PGR 3";Code[50])
        {
        }
        field(50131;"Item Category PGR 4";Code[50])
        {
        }
    }



}