table 50102 "Customer Channel"
{
    LookupPageId = "Customer Channel List";
    DataCaptionFields = Code;

    fields
    {
        field(1;Code;Text[20])
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