tableextension 50116 "Ext50116-FALedgerEntry" extends "FA Ledger Entry"
{
    fields
    {
        field(50100;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass='1,2,3';
            TableRelation="Dimension Value".Code where ("Global Dimension No."=CONST(3));            
        }
        field(50101;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass='1,2,4';
            TableRelation="Dimension Value".Code where ("Global Dimension No."=CONST(4));
        }
    }
    
    var
        myInt : Integer;
}