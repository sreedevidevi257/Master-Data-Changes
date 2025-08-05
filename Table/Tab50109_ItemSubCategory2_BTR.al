table 50109 "Item Sub Category 2"
{
    LookupPageId = "Item Sub Category 2";
    DataCaptionFields = Code;
    fields
    {
        field(1;Code;Code[20])
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