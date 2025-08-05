page 50101 "Supplier Category"
{    
    PageType = List;
    SourceTable = "Supplier Category";
    UsageCategory = Lists;
    ApplicationArea = All;    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";"Code")
                {                    
                }
                
                field(Description;Description)
                {
                }
            }
        }
    }
}