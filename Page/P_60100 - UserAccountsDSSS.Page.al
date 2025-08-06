// page 50001 "User Accounts_DSSS"
// {
//     Caption = 'User Accounts';
//     PageType = List;
//     SourceTable = "User Account_DSS";

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 // field("User ID"; Rec."User ID")
//                 // {
//                 //     ApplicationArea = All;
//                 //     Caption = 'User ID';
//                 //     ToolTip = 'Specifies id of user.';
//                 // }
//                 // field("Account Type"; Rec."Account Type")
//                 // {
//                 //     ApplicationArea = All;
//                 //     Caption = 'Account Type';
//                 //     ToolTip = 'Specifies type of Dimension.';
//                 // }
//                 field("Dimension Code"; Rec."Dimension Code")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Dimension Code';
//                     ToolTip = 'Specifies Dimension Code';
//                 }
//                 field("Dimension Value"; Rec."Dimension Value")
//                 {
//                     ApplicationArea = ALL;
//                 }
//             }
//         }
//     }

//     trigger OnClosePage()
//     begin
//         if ((Rec."Dimension Code" <> '') and (Rec."Dimension Value" = '')) then
//             Error('Please Put Dimension Value');
//     end;

//     var
// }