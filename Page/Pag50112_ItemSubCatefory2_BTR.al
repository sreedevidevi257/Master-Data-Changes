page 50112 "Item Sub Category 2"
{
    PageType = List;
    SourceTable = "Item Sub Category 2";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code;Code)
                {                    
                }
                field(Description;Description)
                {                    
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction();
                begin
                end;
            }
        }
    }
}