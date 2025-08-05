page 50100 "HIP List"
{
    PageType = List;
    SourceTable = HIP;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HIP Code";"HIP Code")
                {
                   //ApplicationArea = All;
 
                }
                field("HIP Name";"HIP Name")
                {
                    //ApplicationArea = All;

                }
            }
        }
        
    }
    
}