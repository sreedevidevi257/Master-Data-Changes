table 50104 "Additional Bank Account"
{
    LookupPageID = "Additional Bank Account List";

    fields
    {
        field(1;"Company Name";Text[50])
        {
            Caption = 'Name';
            //DataClassification = ToBeClassified;
        }
        field(2;"Giro No.";Text[20])
        {
            Caption = 'Giro No.';
        }
        field(3;"Bank Name";Text[50])
        {
            Caption = 'Bank Name';
        }
        field(4;"Bank Branch No.";Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(5;"Bank Account No.";Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(6;"Payment Routing No.";Text[20])
        {
            Caption = 'Payment Routing No.';
        }
        field(7;IBAN;Code[50])
        {
            Caption = 'IBAN';
            //DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                CheckIBAN(IBAN);
            end;
        }
        field(8;"SWIFT Code";Code[20])
        {
            Caption = 'SWIFT Code';
            //DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Company Name","Bank Name")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000 : Label 'The number that you entered may not be a valid International Bank Account Number (IBAN). Do you want to continue?';

    [Scope('Personalization')]
    procedure CheckIBAN(IBANCode : Code[100]);
    var
        Modulus97 : Integer;
        I : Integer;
    begin
        IF IBANCode = '' THEN
          EXIT;
        IBANCode := DELCHR(IBANCode);
        Modulus97 := 97;
        IF (STRLEN(IBANCode) <= 5) OR (STRLEN(IBANCode) > 34) THEN
          IBANError;
        ConvertIBAN(IBANCode);
        WHILE STRLEN(IBANCode) > 6 DO
          IBANCode := CalcModulus(COPYSTR(IBANCode,1,6),Modulus97) + COPYSTR(IBANCode,7);
        EVALUATE(I,IBANCode);
        IF (I MOD Modulus97) <> 1 THEN
          IBANError;
    end;

    local procedure ConvertIBAN(var IBANCode : Code[100]);
    var
        I : Integer;
    begin
        IBANCode := COPYSTR(IBANCode,5) + COPYSTR(IBANCode,1,4);
        I := 0;
        WHILE I < STRLEN(IBANCode) DO BEGIN
          I := I + 1;
          IF ConvertLetter(IBANCode,COPYSTR(IBANCode,I,1),I) THEN
            I := 0;
        END;
    end;

    local procedure IBANError();
    begin
        IF NOT CONFIRM(Text000) THEN
          ERROR('');
    end;

    local procedure CalcModulus(Number : Code[10];Modulus97 : Integer) : Code[10];
    var
        I : Integer;
    begin
        EVALUATE(I,Number);
        I := I MOD Modulus97;
        IF I = 0 THEN
          EXIT('');
        EXIT(FORMAT(I));
    end;

    local procedure ConvertLetter(var IBANCode : Code[100];Letter : Code[1];LetterPlace : Integer) : Boolean;
    var
        Letter2 : Code[2];
    begin
        IF (Letter >= 'A') AND (Letter <= 'Z') THEN BEGIN
          CASE Letter OF
            'A':
              Letter2 := '10';
            'B':
              Letter2 := '11';
            'C':
              Letter2 := '12';
            'D':
              Letter2 := '13';
            'E':
              Letter2 := '14';
            'F':
              Letter2 := '15';
            'G':
              Letter2 := '16';
            'H':
              Letter2 := '17';
            'I':
              Letter2 := '18';
            'J':
              Letter2 := '19';
            'K':
              Letter2 := '20';
            'L':
              Letter2 := '21';
            'M':
              Letter2 := '22';
            'N':
              Letter2 := '23';
            'O':
              Letter2 := '24';
            'P':
              Letter2 := '25';
            'Q':
              Letter2 := '26';
            'R':
              Letter2 := '27';
            'S':
              Letter2 := '28';
            'T':
              Letter2 := '29';
            'U':
              Letter2 := '30';
            'V':
              Letter2 := '31';
            'W':
              Letter2 := '32';
            'X':
              Letter2 := '33';
            'Y':
              Letter2 := '34';
            'Z':
              Letter2 := '35';
          END;
          IF LetterPlace = 1 THEN
            IBANCode := Letter2 + COPYSTR(IBANCode,2)
          ELSE BEGIN
            IF LetterPlace = STRLEN(IBANCode) THEN
              IBANCode := COPYSTR(IBANCode,1,LetterPlace - 1) + Letter2
            ELSE
              IBANCode :=
                COPYSTR(IBANCode,1,LetterPlace - 1) + Letter2 + COPYSTR(IBANCode,LetterPlace + 1);
          END;
          EXIT(TRUE);
        END;
        IF (Letter >= '0') AND (Letter <= '9') THEN
          EXIT(FALSE);

        IBANError;
    end;
}

