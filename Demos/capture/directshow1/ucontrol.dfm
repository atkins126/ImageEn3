object fcontrol: Tfcontrol
  Left = 254
  Top = 169
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Controls'
  ClientHeight = 173
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 4
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label3: TLabel
    Left = 312
    Top = 5
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label2: TLabel
    Left = 520
    Top = 4
    Width = 94
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '---'
  end
  object PlayButton: TSpeedButton
    Left = 8
    Top = 52
    Width = 33
    Height = 35
    Flat = True
    Glyph.Data = {
      96120000424D96120000000000003600000028000000380000001C0000000100
      1800000000006012000000000000000000000000000000000000D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD6E7EA
      D5E5E8D2E3E6D1E1E4D0E0E3D0E0E3D1E1E4D2E3E6D5E5E8D6E7EAD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E6E6E6E4E4E4E2E2E2E0E0E0DFDFDF
      DFDFDFE0E0E0E2E2E2E4E4E4E6E6E6E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD6
      E7EAD3E4E7CCDCDFC5D4D7BDCCCEB8C6C9B5C3C5B5C3C5B8C6C9BDCCCEC5D4D7
      CCDCDFD3E4E7D6E7EAD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E6E6E6E3E3E3DBDBDBD3D3D3CB
      CBCBC5C5C5C2C2C2C2C2C2C5C5C5CBCBCBD3D3D3DBDBDBE3E3E3E6E6E6E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD6E6E9CEDEE1C1D0D3B2C0C2A2AFB194A0A28B96988690928690928B
      969894A0A2A2AFB1B2C0C2C1D0D3CEDEE1D6E6E9D8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5DDDDDDCFCF
      CFBFBFBFAEAEAE9F9F9F9595959090909090909595959F9F9FAEAEAEBFBFBFCF
      CFCFDDDDDDE5E5E5E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD5E5E8CBDADDB9C7CAABAEABB98B70B06032D05C18E45B
      0DE2590BC956149B552C9E6B4C89847F8B9698A1AEB0B9C7CACBDADDD5E5E8D8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E4E4E4
      D9D9D9C6C6C6ADADAD8888885B5B5B5454545353535151514F4F4F5050506767
      67838383959595ADADADC6C6C6D9D9D9E4E4E4E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD6E6E9CBDADDB6C4C6C09C83CD6022FD6E1B
      FF7E34FF8038FF8038FF7F35FF7B2FFF7323F66714B050198860477E868899A5
      A7B5C4C6CBDADDD6E6E9D8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E5E5E5D9D9D9C3C3C3989898595959656565767676787878787878777777
      7373736A6A6A5E5E5E4A4A4A5D5D5D868686A4A4A4C3C3C3D9D9D9E5E5E5E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD7E8EBCEDEE1BECACBCF8E66F4
      6512FF8A49FF8A49FF8541FF813BFF7D32FF7A2EFF782BFF792CFF792CFF792C
      F3641180503484878599A5A7B9C7CACEDEE1D7E8EBD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E7E7E7DDDDDDC9C9C98989895C5C5C8383838383837E7E7E7A
      7A7A7575757272727070707070707070707070705B5B5B4D4D4D868686A4A4A4
      C6C6C6DDDDDDE7E7E7E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD3E4E7C1D0
      D3D49672FD6E1BF9823FF47125F26B1CF16918F16514F36615F86F20FE782AFF
      792CFF792CFF782BFF7A2EFA6B187D4F347E8688A1AEB0C1D0D3D3E4E7D8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E3E3E3CFCFCF9292926565657B7B7B6868
      686262626060605C5C5C5D5D5D6666666F6F6F70707070707070707072727262
      62624C4C4C868686ADADADCFCFCFE3E3E3E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D6E7EACCDCDFD1C1B5F86916FF985FF4772FF9B58FFDEEE5FEF8F4FDE6D9F7AA
      7FF16D21F36818FA7325FF7A2EFF7B2FFF792CFF7B2FF26310A16C4D8B9698B2
      C0C2CCDCDFD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E6E6E6DBDBDBBFBFBF606060
      9292926F6F6FB1B1B1EDEDEDF7F7F7E5E5E5A5A5A56565655F5F5F6A6A6A7272
      727373737070707373735A5A5A686868959595BFBFBFDBDBDBE8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD5E5E8CBD5D7E77B3CFF9053FF9C65F57C36FFFFFFFFFFFF
      FFFFFFFFFFFFFFFEFDFCDCCAF4935CF16A1CF46C1DFC7A2FFF7E34FF7C31FF7C
      31AD5019898682A2AFB1C3D2D5D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E4E4E4D5
      D5D57474748A8A8A969696747474FFFFFFFFFFFFFFFFFFFFFFFFFEFEFEDADADA
      8D8D8D6161616363637272727676767474747474744A4A4A858585AEAEAED1D1
      D1E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD2E3E6D7CCC2FD6E1BFFA06CFF9D66F6
      7F3BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF9F5FACDB2F38647F16818
      F77023FD7B30FF7F35FD6E1B9F6C4D94A0A2BCCBCED8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E2E2E2CACACA6565659B9B9B979797787878FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF8F8F8CACACA7F7F7F5F5F5F686868737373777777656565
      6868689F9F9FCACACAE8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD1E1E4E4AA88FF86
      43FFA06CFF9E68F68240FFEFE6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEF2ECF9BC99F37D39F2691CF87529FE7C31B05C2C8B9698B7C5C8D8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E0E0E0A6A6A67F7F7F9B9B9B9898987B7B7BEEEE
      EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F2B8B8B875757561
      61616C6C6C747474575757959595C4C4C4E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D0E0E3F28547FF965CFF9F69FF9960F78644FFEDE3FFF6F1FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDE8DDF7A97DF27124FC7D35D5601C86
      9092B4C2C4D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8DFDFDF7E7E7E909090999999
      9393937F7F7FECECECF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFE7E7E7A4A4A4686868757575585858909090C1C1C1E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD0E0E3FB7327FF9A62FF9C65FF9C65F88949FFE7DAFFEEE5
      FFF5F0FFFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF4EDF793
      59FC813CEB6215869092B4C2C4D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8DFDFDF6B
      6B6B949494969696969696828282E6E6E6EDEDEDF5F5F5FDFDFDFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F38C8C8C7A7A7A5A5A5A909090C1C1
      C1E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD1E1E4FB782DFF9960FF9D66FF9C65F9
      8C4FFFE4D6FFE9DEFFEFE6FFF3ECFFF6F1FFF6F1FFF4EFFFF4EEFFF4EFFFF6F1
      FFF8F4FEE9DEF79259FC8542EF67198B9698B7C5C8D8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E0E0E0707070939393979797969696868686E3E3E3E8E8E8EEEEEEF2
      F2F2F5F5F5F5F5F5F4F4F4F3F3F3F4F4F4F5F5F5F8F8F8E8E8E88C8C8C7E7E7E
      5E5E5E959595C4C4C4E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD2E3E6F3965FFF93
      57FF9F6BFF9A62FA8F53FFDFCEFFE2D3FFE5D7FFE7DAFFE7DAFFE4D6FFE0CFFF
      DECCFFDECCFFDDCAFCC3A3F8945CF6813BFD8A48DB682494A0A2BCCBCED8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E2E2E29090908D8D8D9A9A9A949494898989DDDD
      DDE1E1E1E4E4E4E6E6E6E6E6E6E3E3E3DEDEDEDCDCDCDCDCDCDBDBDBC0C0C08E
      8E8E7979798383836060609F9F9FCACACAE8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D5E5E8C9AE9CFF8541FFAA7BFF9E68FA9157FFD8C3FFD9C4FFDAC5FFDAC5FFD8
      C3FFD6BFFFD1B9FFCEB4FDBE9AFA9F6DF78544FA8847FD8E50FF8B4AC36B39A2
      AFB1C3D2D5D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E4E4E4ACACAC7E7E7EA5A5A5
      9898988B8B8BD6D6D6D7D7D7D8D8D8D8D8D8D6D6D6D4D4D4CFCFCFCCCCCCBABA
      BA9A9A9A7E7E7E818181878787848484666666AEAEAED1D1D1E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD7E8EBCDCDCAFF7A2EFFB389FFAC7EFB9459FFD3BAFFD0B7
      FFCFB4FFCDB2FFCDB1FFCCB0FEBF9CFBA574F88B4EFA8C4EFD9358FF995FFF9A
      62FF7628B9947DB2C0C2CCDCDFD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E7E7E7CC
      CCCC727272AFAFAFA7A7A78E8E8ED0D0D0CECECECCCCCCCACACACACACAC9C9C9
      BBBBBBA0A0A08585858585858D8D8D9393939494946E6E6E919191BFBFBFDBDB
      DBE8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD3E4E7CA9D82FFA16EFFC19FFB
      955BFFCDB2FFC8AAFFC5A6FFC4A4FFC2A1FDAC80FB965DFA9054FD975DFF9D67
      FF9E68FF9E68FF975DD5682AABB2B0C1D0D3D3E4E7D8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E3E3E39A9A9A9C9C9CBEBEBE8F8F8FCACACAC5C5C5C2C2C2C1
      C1C1BFBFBFA8A8A89090908A8A8A919191979797989898989898919191616161
      B1B1B1CFCFCFE3E3E3E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD7E8EBCED2
      D1FF8038FFB992FB955BFCA270FEB891FFBD97FDB186FB9E69FB9358FC965DFE
      9960FF9E68FF9E68FF9F69FFA16EFF701FC0A896B9C7CACEDEE1D7E8EBD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E7E7E7D1D1D1787878B5B5B58F8F8F9D9D
      9DB4B4B4B9B9B9ACACAC9898988D8D8D9090909393939898989898989999999C
      9C9C676767A5A5A5C6C6C6DDDDDDE7E7E7E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD6E6E9CCC3BCFF813AFEB48AFCA574FB9A63FB9961FB975EFD99
      61FE9D68FF9A62FF9E68FF9E68FF9F6BFF9F69FF7628CF9D7EB6C4C6CBDADDD6
      E6E9D8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E5E5E5C2C2C2
      797979AFAFAFA0A0A09494949393939191919393939898989494949898989898
      989A9A9A9999996E6E6E999999C3C3C3D9D9D9E5E5E5E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD5E5E8CCC2BAFF833EFFAF81FFCCAF
      FFCAACFFBD98FFB084FFA472FF9F6BFFA06CFF9F69FF9053FF7120D49D7EBECB
      CCCBDADDD5E5E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E4E4E4C1C1C17C7C7CAAAAAAC9C9C9C7C7C7B9B9B9ABABAB9F9F9F
      9A9A9A9B9B9B9999998A8A8A6868689A9A9ACACACAD9D9D9E4E4E4E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD6E6E9CD
      D0CFCA9A7CFF8440FF9B63FFB48AFFB992FFB084FFA16EFF8744FF7425E9874F
      D1C5BBC1D1D3CEDEE1D6E6E9D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5CFCFCF9696967D7D7D959595B0
      B0B0B5B5B5ABABAB9C9C9C8080806B6B6B818181C3C3C3D0D0D0DDDDDDE5E5E5
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD7E8EBD8E5E8CDCBC7C9AC99F39C69FB823CFB7D35F29058E4
      B497D7CCC3CBD7D9CCDCDFD3E4E7D6E7EAD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E7E7E7E4E4
      E4CACACAA9A9A99696967A7A7A7575758A8A8AB1B1B1CACACAD6D6D6DBDBDBE3
      E3E3E6E6E6E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
    NumGlyphs = 2
    OnClick = OnPlayButton
  end
  object PauseButton: TSpeedButton
    Left = 41
    Top = 52
    Width = 33
    Height = 35
    Enabled = False
    Flat = True
    Glyph.Data = {
      96120000424D96120000000000003600000028000000380000001C0000000100
      1800000000006012000000000000000000000000000000000000D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D6E7EAD5E5E8D2E3E6D1E1E4D0E0E3D0E0E3D1E1E4D2E3E6D5E5E8D6E7EAD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E6E6E6E4E4E4E2E2E2E0E0E0
      DFDFDFDFDFDFE0E0E0E2E2E2E4E4E4E6E6E6E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD6E7EAD3E4E7CCDCDFC5D4D7BDCCCEB8C6C9B5C3C5B5C3C5B8C6C9BDCCCE
      C5D4D7CCDCDFD3E4E7D6E7EAD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E6E6E6E3E3E3DBDBDBD3
      D3D3CBCBCBC5C5C5C2C2C2C2C2C2C5C5C5CBCBCBD3D3D3DBDBDBE3E3E3E6E6E6
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD6E6E9CEDEE1C1D0D3B2C0C2A2AFB194A0A28B969886909286
      90928B969894A0A2A2AFB1B2C0C2C1D0D3CEDEE1D6E6E9D8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5DDDD
      DDCFCFCFBFBFBFAEAEAE9F9F9F9595959090909090909595959F9F9FAEAEAEBF
      BFBFCFCFCFDDDDDDE5E5E5E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD5E5E8CBDADDB9C7CAABAEABB98B70B06032D05C
      18E45B0DE2590BC956149B552C9E6B4C89847F8B9698A1AEB0B9C7CACBDADDD5
      E5E8D8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E4E4E4D9D9D9C6C6C6ADADAD8888885B5B5B5454545353535151514F4F4F5050
      50676767838383959595ADADADC6C6C6D9D9D9E4E4E4E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD6E6E9CBDADDB6C4C6C09C83CD6022
      FD6E1BFF7E34FF8038FF8038FF7F35FF7B2FFF7323F66714B050198860477E86
      8899A5A7B5C4C6CBDADDD6E6E9D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E5E5E5D9D9D9C3C3C3989898595959656565767676787878787878
      7777777373736A6A6A5E5E5E4A4A4A5D5D5D868686A4A4A4C3C3C3D9D9D9E5E5
      E5E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD7E8EBD7E8EBCEDEE1BECACBCF
      8E66F46512FF8A49FF8A49FF8541FF813BFF7D32FF7A2EFF782BFF792CFF792C
      FF792CF3641180503484878599A5A7B9C7CACEDEE1D7E8EBD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E7E7E7E7E7E7DDDDDDC9C9C98989895C5C5C8383838383837E
      7E7E7A7A7A7575757272727070707070707070707070705B5B5B4D4D4D868686
      A4A4A4C6C6C6DDDDDDE7E7E7E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD7E8EBD3E4
      E7C1D0D3D49672FD6E1BFF9357F4752DF3732AF27027F16E23F16B20F06A1DEE
      681BEE6619EE6417ED6315FF7A2EFA6B187D4F347E8688A1AEB0C1D0D3D3E4E7
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E7E7E7E3E3E3CFCFCF9292926565658D8D
      8D6D6D6D6B6B6B6868686666666363636161615F5F5F5E5E5E5C5C5C5B5B5B72
      72726262624C4C4C868686ADADADCFCFCFE3E3E3E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD4E5E7CCDCDFD1C1B5F86916FF985FFF9357F57830FFDECBFFFBF9FFC2
      9FF26E25F16C21FFD9C3FFFBF8FFBD97ED6517FF792CFF7B2FF26310A16C4D8B
      9698B2C0C2CCDCDFD6E7EAD8E9ECE8E8E8E8E8E8E8E8E8E4E4E4DBDBDBBFBFBF
      6060609292928D8D8D707070DCDCDCFBFBFBBEBEBE666666646464D7D7D7FBFB
      FBB9B9B95C5C5C7070707373735A5A5A686868959595BFBFBFDBDBDBE6E6E6E8
      E8E8D8E9ECD8E9ECD8E9ECD1E1E4CAD4D6E77B3CFF9053FF9C65FF975DF67A34
      FFFFFFFFFFFFFFF0E7F37228F26F25FFFFFFFFFFFFFFEEE5EF671AFF7E34FF7C
      31FF7C31AD5019898682A2AFB1C4D3D6D5E5E8D8E9ECE8E8E8E8E8E8E8E8E8E0
      E0E0D4D4D47474748A8A8A969696919191737373FFFFFFFFFFFFEFEFEF6A6A6A
      676767FFFFFFFFFFFFEDEDED5F5F5F7676767474747474744A4A4A858585AEAE
      AED2D2D2E4E4E4E8E8E8D8E9ECD8E9ECD8E9ECCBDBDED5CAC1FD6E1BFFA06CFF
      9D66FF9A62F77D38FFFFFEFFFFFFFFF1E8F4752CF3722AFFFFFEFFFFFFFFEFE7
      F0691EFF8038FF7F35FF7F35FD6E1B9F6C4D94A0A2BDCCCED2E3E6D8E9ECE8E8
      E8E8E8E8E8E8E8DADADAC8C8C86565659B9B9B979797949494767676FFFFFFFF
      FFFFF0F0F06D6D6D6A6A6AFFFFFFFFFFFFEEEEEE616161787878777777777777
      6565656868689F9F9FCBCBCBE2E2E2E8E8E8D8E9ECD8E9ECD8E9ECC8D8DAE4AA
      88FF8643FFA06CFF9E68FF9960F8803CFFFFFEFFFFFFFFF1E9F57731F4752EFF
      FFFEFFFFFFFFEFE6F16C21FF813BFF813AFF813AFF7D32B05C2C8B9698B8C6C9
      D1E1E4D8E9ECE8E8E8E8E8E8E8E8E8D7D7D7A6A6A67F7F7F9B9B9B9898989393
      93797979FFFFFFFFFFFFF0F0F07070706E6E6EFFFFFFFFFFFFEEEEEE6464647A
      7A7A797979797979757575575757959595C5C5C5E0E0E0E8E8E8D8E9ECD8E9EC
      D8E9ECC6D6D9F28547FF965CFF9F69FF9960FF9A62FA8341FFF9F7FFFFFFFFF1
      EAF67A35F57932FFFFFEFFFFFFFFF0E7F27026FF8440FF823DFF823DFF833ED5
      601C869092B5C3C5D0E0E3D8E9ECE8E8E8E8E8E8E8E8E8D5D5D57E7E7E909090
      9999999393939494947C7C7CF9F9F9FFFFFFF0F0F0737373717171FFFFFFFFFF
      FFEFEFEF6868687D7D7D7B7B7B7B7B7B7C7C7C585858909090C2C2C2DFDFDFE8
      E8E8D8E9ECD8E9ECD8E9ECC6D6D9FB7327FF9A62FF9C65FF9C65FF9C65FB8645
      FFF3EEFFF9F7FFF1E9F77E38F67C36FFFFFEFFFFFFFFF1E8F3722AFF8947FF86
      43FF8541FF8744EB6215869092B5C3C5D0E0E3D8E9ECE8E8E8E8E8E8E8E8E8D5
      D5D56B6B6B9494949696969696969696967F7F7FF3F3F3F9F9F9F0F0F0767676
      747474FFFFFFFFFFFFF0F0F06A6A6A8282827F7F7F7E7E7E8080805A5A5A9090
      90C2C2C2DFDFDFE8E8E8D8E9ECD8E9ECD8E9ECC8D8DAFB782DFF9960FF9D66FF
      9C65FF9C65FC8949FFECE5FFF1ECFFE9DFF9803DF87E3AFFF9F6FFFBF9FFF0E7
      F4762EFF8F50FF8C4BFF8A49FF8A49EF67198B9698B8C6C9D1E1E4D8E9ECE8E8
      E8E8E8E8E8E8E8D7D7D7707070939393979797969696969696828282ECECECF1
      F1F1E8E8E8797979777777F9F9F9FBFBFBEFEFEF6E6E6E888888858585838383
      8383835E5E5E959595C5C5C5E0E0E0E8E8E8D8E9ECD8E9ECD8E9ECCBDBDEF396
      5FFF9357FF9F6BFF9A62FF9C65FD8C4DFFE4DBFFE6DDFFDFD1FA8341F9813EFF
      ECE5FFF0EAFFE8DDF57832FF9357FF9154FF8F50FF8D4DDB682494A0A2BDCCCE
      D2E3E6D8E9ECE8E8E8E8E8E8E8E8E8DADADA9090908D8D8D9A9A9A9494949696
      96858585E4E4E4E6E6E6DEDEDE7C7C7C7A7A7AECECECF0F0F0E7E7E77171718D
      8D8D8B8B8B8888888686866060609F9F9FCBCBCBE2E2E2E8E8E8D8E9ECD8E9EC
      D8E9ECD1E1E4C8AC9BFF8541FFAA7BFF9E68FF9A62FE8D50FFDCCFFFDCCFFFD4
      C2FB8646FA8342FFE0D5FFE5DCFFE0D2F77C36FF965CFF955AFF9256FF8B4AC3
      6B39A2AFB1C4D3D6D5E5E8D8E9ECE8E8E8E8E8E8E8E8E8E0E0E0AAAAAA7E7E7E
      A5A5A5989898949494878787DCDCDCDCDCDCD3D3D38080807C7C7CE0E0E0E5E5
      E5DFDFDF7474749090908F8F8F8C8C8C848484666666AEAEAED2D2D2E4E4E4E8
      E8E8D8E9ECD8E9ECD8E9ECD5E5E8CCCCCAFF7A2EFFB389FFAC7EFFA16EFF9053
      FFD3C4FFD0C0FFCAB6FC894AFC8647FFD3C3FFD8CBFFD8C8F87E3BFF9A62FF99
      60FF9A62FF7628B9947DB2C0C2CCDCDFD6E7EAD8E9ECE8E8E8E8E8E8E8E8E8E4
      E4E4CBCBCB727272AFAFAFA7A7A79C9C9C8A8A8AD3D3D3D0D0D0CACACA838383
      808080D3D3D3D8D8D8D7D7D77777779494949393939494946E6E6E919191BFBF
      BFDBDBDBE6E6E6E8E8E8D8E9ECD8E9ECD8E9ECD7E8EBD3E4E7C89C81FFA16EFF
      C19FFFB186FF9053FFC6AFFFC7B4FFB490FE8B4DFD894BFFC1A9FFCEBDFFBE9E
      F9813FFF9E68FF9E68FF975DD5682AABB2B0C1D0D3D3E4E7D8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E7E7E7E3E3E39999999C9C9CBEBEBEADADAD8A8A8AC5C5C5C7
      C7C7B1B1B1858585838383C1C1C1CECECEBBBBBB7A7A7A989898989898919191
      616161B1B1B1CFCFCFE3E3E3E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD7E8
      EBCED1D0FF8038FFB992FFC7A8FF9053FF9053FF9053FF9052FE8E51FE8C4EFD
      8A4BFC8849FB8646FA8443FF9F69FFA16EFF701FC0A896B9C7CACEDEE1D7E8EB
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E7E7E7D0D0D0787878B5B5B5C4C4
      C48A8A8A8A8A8A8A8A8A8989898888888686868484848282828080807D7D7D99
      99999C9C9C676767A5A5A5C6C6C6DDDDDDE7E7E7E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD6E6E9CBC2BBFF813AFFBE99FFCFB5FFBF9BFFB389FFA7
      77FF9F6BFF9F6BFF9A62FF9E68FF9E68FF9F6BFF9F69FF7628CF9D7EB6C4C6CB
      DADDD6E6E9D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5
      C1C1C1797979BABABACCCCCCBBBBBBAFAFAFA2A2A29A9A9A9A9A9A9494949898
      989898989A9A9A9999996E6E6E999999C3C3C3D9D9D9E5E5E5E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD5E5E8CBC1BAFF833EFFAF81
      FFCCAFFFCAACFFBD98FFB084FFA472FF9F6BFFA06CFF9F69FF9053FF7120D49D
      7EBECBCCCBDADDD5E5E8D8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E4E4E4C0C0C07C7C7CAAAAAAC9C9C9C7C7C7B9B9B9ABABAB
      9F9F9F9A9A9A9B9B9B9999998A8A8A6868689A9A9ACACACAD9D9D9E4E4E4E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD6
      E6E9CDCFCEC8997CFF8440FF9B63FFB48AFFB992FFB084FFA16EFF8744FF7425
      E9874FD1C5BBC1D1D3CEDEE1D6E6E9D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5CECECE9595957D7D7D95
      9595B0B0B0B5B5B5ABABAB9C9C9C8080806B6B6B818181C3C3C3D0D0D0DDDDDD
      E5E5E5E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD7E8EBD8E5E8CCCBC7C8AB98F39C69FB823CFB7D35F2
      9058E4B497D7CCC3CBD7D9CCDCDFD3E4E7D6E7EAD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E7E7
      E7E4E4E4CACACAA8A8A89696967A7A7A7575758A8A8AB1B1B1CACACAD6D6D6DB
      DBDBE3E3E3E6E6E6E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
    NumGlyphs = 2
    OnClick = OnPauseButton
  end
  object StopButton: TSpeedButton
    Left = 74
    Top = 52
    Width = 33
    Height = 35
    Enabled = False
    Flat = True
    Glyph.Data = {
      96120000424D96120000000000003600000028000000380000001C0000000100
      1800000000006012000000000000000000000000000000000000D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D6E7EAD5E5E8D2E3E6D1E1E4D0E0E3D0E0E3D1E1E4D2E3E6D5E5E8D6E7EAD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E6E6E6E4E4E4E2E2E2E0E0E0
      DFDFDFDFDFDFE0E0E0E2E2E2E4E4E4E6E6E6E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD6E7EAD3E4E7CCDCDFC5D4D7BDCCCEB8C6C9B5C3C5B5C3C5B8C6C9BDCCCE
      C5D4D7CCDCDFD3E4E7D6E7EAD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E6E6E6E3E3E3DBDBDBD3
      D3D3CBCBCBC5C5C5C2C2C2C2C2C2C5C5C5CBCBCBD3D3D3DBDBDBE3E3E3E6E6E6
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD6E6E9CEDEE1C1D0D3B2C0C2A2AFB194A0A28B969886909286
      90928B969894A0A2A2AFB1B2C0C2C1D0D3CEDEE1D6E6E9D8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5DDDD
      DDCFCFCFBFBFBFAEAEAE9F9F9F9595959090909090909595959F9F9FAEAEAEBF
      BFBFCFCFCFDDDDDDE5E5E5E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD5E5E8CBDADDB9C7CAABAEABB98B70B06032D05C
      18E45B0DE2590BC956149B552C9E6B4C89847F8B9698A1AEB0B9C7CACBDADDD5
      E5E8D8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E4E4E4D9D9D9C6C6C6ADADAD8888885B5B5B5454545353535151514F4F4F5050
      50676767838383959595ADADADC6C6C6D9D9D9E4E4E4E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD6E6E9CBDADDB6C4C6C09C83CD6022
      FD6E1BFF7E34FF8038FF8038FF7F35FF7B2FFF7323F66714B050198860477E86
      8899A5A7B5C4C6CBDADDD6E6E9D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E5E5E5D9D9D9C3C3C3989898595959656565767676787878787878
      7777777373736A6A6A5E5E5E4A4A4A5D5D5D868686A4A4A4C3C3C3D9D9D9E5E5
      E5E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD7E8EBCEDEE1BECACBCF
      8E66F46512FF8A49FF8A49FF8541FF813BFF7D32FF7A2EFF782BFF792CFF792C
      FF792CF3641180503484878599A5A7B9C7CACEDEE1D7E8EBD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E7E7E7DDDDDDC9C9C98989895C5C5C8383838383837E
      7E7E7A7A7A7575757272727070707070707070707070705B5B5B4D4D4D868686
      A4A4A4C6C6C6DDDDDDE7E7E7E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD3E4
      E7C1D0D3D49672FD6E1BFF9357FF8E4EFF8B4AFF8744FF823DFF7E34FF7B2FFF
      792CFF792CFF792CFF782BFF7A2EFA6B187D4F347E8688A1AEB0C1D0D3D3E4E7
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E3E3E3CFCFCF9292926565658D8D
      8D8787878484848080807B7B7B76767673737370707070707070707070707072
      72726262624C4C4C868686ADADADCFCFCFE3E3E3E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD6E7EACCDCDFD1C1B5F86916FF985FFF9357FF9053FF8D4DFF8947FF84
      40FF813AFF7F35FF7C31FF7B2FFF7B2FFF7B2FFF792CFF7B2FF26310A16C4D8B
      9698B2C0C2CCDCDFD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E6E6E6DBDBDBBFBFBF
      6060609292928D8D8D8A8A8A8686868282827D7D7D7979797777777474747373
      737373737373737070707373735A5A5A686868959595BFBFBFDBDBDBE8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD3E4E7CBD5D7E77B3CFF9053FF9C65FF975DF9752B
      F97428F97428F36C1FF1691BF1691BF1691BF1691BF1691BF1691BFF7E34FF7C
      31FF7C31AD5019898682A2AFB1C4D3D6D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E3
      E3E3D5D5D57474748A8A8A9696969191916D6D6D6C6C6C6C6C6C646464606060
      6060606060606060606060606060607676767474747474744A4A4A858585AEAE
      AED2D2D2E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD1E1E4D7CCC2FD6E1BFFA06CFF
      9D66FF9A62F8782FFFFBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      F1691BFF8038FF7F35FF7F35FD6E1B9F6C4D94A0A2BDCCCED8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E0E0E0CACACA6565659B9B9B979797949494707070FBFBFBFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF606060787878777777777777
      6565656868689F9F9FCBCBCBE8E8E8E8E8E8D8E9ECD8E9ECD8E9ECCFDFE2E4AA
      88FF8643FFA06CFF9E68FF9960F77A33FFFAF7FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF1691BFF813BFF813AFF813AFF7D32B05C2C8B9698B8C6C9
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8DEDEDEA6A6A67F7F7F9B9B9B9898989393
      93727272FAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6060607A
      7A7A797979797979757575575757959595C5C5C5E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECCEDEE1F28547FF965CFF9F69FF9960FF9A62F67D38FFF9F5FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1691BFF8440FF823DFF823DFF833ED5
      601C869092B5C3C5D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8DDDDDD7E7E7E909090
      999999939393949494757575F8F8F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFF6060607D7D7D7B7B7B7B7B7B7C7C7C585858909090C2C2C2E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECCEDEE1FB7327FF9A62FF9C65FF9C65FF9C65F6803C
      FFF1E9FFFCFAFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1691BFF8947FF86
      43FF8541FF8744EB6215869092B5C3C5D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8DD
      DDDD6B6B6B949494969696969696969696787878F0F0F0FCFCFCFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFF6060608282827F7F7F7E7E7E8080805A5A5A9090
      90C2C2C2E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECCFDFE2FB782DFF9960FF9D66FF
      9C65FF9C65F68241FFE6D9FFEFE6FFF4EDFFF7F3FFF9F6FFFAF9FFFCF9FFFCFA
      F26A1CFF8F50FF8C4BFF8A49FF8A49EF67198B9698B8C6C9D8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8DEDEDE7070709393939797979696969696967B7B7BE5E5E5EE
      EEEEF3F3F3F7F7F7F9F9F9FAFAFAFBFBFBFCFCFC616161888888858585838383
      8383835E5E5E959595C5C5C5E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD1E1E4F396
      5FFF9357FF9F6BFF9A62FF9C65F48545FFDECCFFE1D1FFE3D4FFE5D7FFE8DBFF
      EBE2FFF0E6FFF3EDF87326FF9357FF9154FF8F50FF8D4DDB682494A0A2BDCCCE
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E0E0E09090908D8D8D9A9A9A9494949696
      967E7E7EDCDCDCDFDFDFE2E2E2E4E4E4E7E7E7EAEAEAEFEFEFF3F3F36A6A6A8D
      8D8D8B8B8B8888888686866060609F9F9FCBCBCBE8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD3E4E7C8AC9BFF8541FFAA7BFF9E68FF9A62F4874AFFD6C0FFD4BDFFD3
      BBFFD3BCFFD6C0FFDBC6FFE1D0FFE9DEF97428FF965CFF955AFF9256FF8B4AC3
      6B39A2AFB1C4D3D6D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E3E3E3AAAAAA7E7E7E
      A5A5A5989898949494818181D4D4D4D2D2D2D1D1D1D1D1D1D4D4D4D9D9D9DFDF
      DFE8E8E86C6C6C9090908F8F8F8C8C8C848484666666AEAEAED2D2D2E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD7E8EBCCCCCAFF7A2EFFB389FFAC7EFFA16EF3894F
      FFCAAEFFC6A7FFC2A1FFC2A0FFC3A3FFC8AAFFCFB6FFDBC7F66F23FF9A62FF99
      60FF9A62FF7628B9947DB2C0C2CCDCDFD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E7
      E7E7CBCBCB727272AFAFAFA7A7A79C9C9C838383C7C7C7C3C3C3BFBFBFBEBEBE
      C0C0C0C5C5C5CDCDCDD9D9D96767679494949393939494946E6E6E919191BFBF
      BFDBDBDBE8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD3E4E7C89C81FFA16EFF
      C19FFFB186F38B51F38A4FF4874AF48445F58141F6803DF77E38F77A33F8782E
      F57023FF9E68FF9E68FF975DD5682AABB2B0C1D0D3D3E4E7D8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E3E3E39999999C9C9CBEBEBEADADAD85858584848481
      81817D7D7D7A7A7A797979767676727272707070676767989898989898919191
      616161B1B1B1CFCFCFE3E3E3E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD7E8
      EBCED1D0FF8038FFB992FFC7A8FFB78FFFAD7FFFA06CFF9D66FF9C65FF9C65FF
      9C65FF9A62FF9E68FF9E68FF9F69FFA16EFF701FC0A896B9C7CACEDEE1D7E8EB
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E7E7E7D0D0D0787878B5B5B5C4C4
      C4B3B3B3A8A8A89B9B9B97979796969696969696969694949498989898989899
      99999C9C9C676767A5A5A5C6C6C6DDDDDDE7E7E7E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD6E6E9CBC2BBFF813AFFBE99FFCFB5FFBF9BFFB389FFA7
      77FF9F6BFF9F6BFF9A62FF9E68FF9E68FF9F6BFF9F69FF7628CF9D7EB6C4C6CB
      DADDD6E6E9D8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5
      C1C1C1797979BABABACCCCCCBBBBBBAFAFAFA2A2A29A9A9A9A9A9A9494949898
      989898989A9A9A9999996E6E6E999999C3C3C3D9D9D9E5E5E5E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD5E5E8CBC1BAFF833EFFAF81
      FFCCAFFFCAACFFBD98FFB084FFA472FF9F6BFFA06CFF9F69FF9053FF7120D49D
      7EBECBCCCBDADDD5E5E8D8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E4E4E4C0C0C07C7C7CAAAAAAC9C9C9C7C7C7B9B9B9ABABAB
      9F9F9F9A9A9A9B9B9B9999998A8A8A6868689A9A9ACACACAD9D9D9E4E4E4E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD6
      E6E9CDCFCEC8997CFF8440FF9B63FFB48AFFB992FFB084FFA16EFF8744FF7425
      E9874FD1C5BBC1D1D3CEDEE1D6E6E9D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E5E5E5CECECE9595957D7D7D95
      9595B0B0B0B5B5B5ABABAB9C9C9C8080806B6B6B818181C3C3C3D0D0D0DDDDDD
      E5E5E5E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD7E8EBD8E5E8CCCBC7C8AB98F39C69FB823CFB7D35F2
      9058E4B497D7CCC3CBD7D9CCDCDFD3E4E7D6E7EAD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E7E7
      E7E4E4E4CACACAA8A8A89696967A7A7A7575758A8A8AB1B1B1CACACAD6D6D6DB
      DBDBE3E3E3E6E6E6E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECE8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8D8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8
      E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      D8E9ECD8E9ECE8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8
      E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8E8}
    NumGlyphs = 2
    OnClick = OnStopButton
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 21
    Width = 617
    Height = 21
    Max = 100
    TabOrder = 0
    ThumbLength = 10
    TickMarks = tmTopLeft
    OnChange = TrackBar1Change
  end
  object GroupBox1: TGroupBox
    Left = 138
    Top = 48
    Width = 185
    Height = 121
    Caption = ' Input '
    TabOrder = 1
    object Label4: TLabel
      Left = 7
      Top = 24
      Width = 23
      Height = 13
      Caption = 'Rate'
    end
    object Label5: TLabel
      Left = 4
      Top = 56
      Width = 58
      Height = 13
      Caption = 'Time Format'
    end
    object Edit1: TEdit
      Left = 67
      Top = 20
      Width = 38
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 104
      Top = 20
      Width = 17
      Height = 21
      Min = 1
      Position = 10
      TabOrder = 1
      OnClick = UpDown1Click
    end
    object ComboBox1: TComboBox
      Left = 67
      Top = 52
      Width = 102
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBox1Change
      Items.Strings = (
        'None'
        'Frame'
        'Sample'
        'Field'
        'Byte'
        'MediaTime')
    end
    object Button1: TButton
      Left = 8
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Audio Param.'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 96
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Video Param.'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 336
    Top = 48
    Width = 185
    Height = 121
    Caption = ' Output '
    TabOrder = 2
    object Label6: TLabel
      Left = 8
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Quality'
    end
    object Edit2: TEdit
      Left = 59
      Top = 20
      Width = 38
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = '1'
    end
    object UpDown2: TUpDown
      Left = 96
      Top = 20
      Width = 17
      Height = 21
      Min = 1
      Max = 10
      Position = 10
      TabOrder = 1
      OnClick = UpDown2Click
    end
    object Button3: TButton
      Left = 8
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Audio Param.'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 96
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Video Param.'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 256
    Top = 24
  end
end
