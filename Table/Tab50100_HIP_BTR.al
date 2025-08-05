table 50100 HIP
{
    LookupPageId = "HIP List";
    fields
    {
        field(1;"HIP Code";Code[20])
        
        {
        }
        field(2;"HIP Name";Text[50])
        
        {
        }
    }

    keys
    {
        key(PK;"HIP Code")
        {
            Clustered = true;
        }
    }
    
    
}