table 50101 "Supplier Category"
{
    LookupPageId = "Supplier Category";
    fields
    {
        field(1;"Code";Code[20])
        {
        }
        field(2;Description;Text[50])
        {            
        }
    }

    keys
    {
        key(PK;Code)
        {
            Clustered = true;
        }
    }
}