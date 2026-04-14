pageextension 50103 "PagExt50103_ItemList_BTR" extends "Item List"
{
    layout
    {
        addlast(Item)
        {
            field("HIP Code"; "HIP Code")
            {

            }
            field("Sub Category 1"; "Sub Category 1")
            {
            }
            field("Sub Category 2"; "Sub Category 2")
            {
            }
            field("Item Category PGR 1";"Item Category PGR 1"){
               
            }
            field("Item Category PGR 2";"Item Category PGR 2"){
                
            }
            field("Item Category PGR 3";"Item Category PGR 3"){ 
                
            }
            field("Item Category PGR 4";"Item Category PGR 4"){

            }

        }
    }

    actions
    {
        addlast(Reports)
        {
            action("Supplier Performance Report 2")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Excel;
                RunObject = report "Supplier Performance Report 2";
            }
            action("Supplier Performance Report")
            {
                ApplicationArea = All;
                Promoted = true;
                Image = Excel;
                RunObject = report "Supplier Performance Report";
            }
        }
    }
}