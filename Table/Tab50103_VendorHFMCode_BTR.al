table 50103 "Vendor HFM ICP Codes"
{
    LookupPageId = "Vendor HFM ICP Codes";
    fields
    {
        field(1;"ICP Code";Text[20])
        {
        }
        field(2;Description;Text[50])
        {            
        }
    }

    keys
    {
        key(PK;"ICP Code")
        {
            Clustered = true;
        }
    }    
}