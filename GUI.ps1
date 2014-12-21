# GUI.ps1
# Basic GUI functions

Add-Type -AssemblyName System.Windows.Forms

$QuestionType = New-Object psobject -property @{
    YesNo = 0
    OKCancel = 1
    YesNoCancel = 2
}
# e.g. If (Ask("Save before exit?", "Exit", $QuestionType.YesNoCancel)) {...}
function Ask($Question, $Header, $PossibleAnswers) {
    $Asking = New-Object System.Windows.Forms.Form -property @{
        Text = $Header
        Size = New-Object System.Drawing.Size(420, 180)
        StartPosition = "CenterScreen"
    }
    $lbl = New-Object System.windows.Forms.Label -property @{
        Text = $Question
    }
    
    $btn = New-Object System.windows.Forms.Button
    $btn.Text = "OK/Cancel/Yes/No"
    
    Switch($PossibleAnswers) {
        $QuestionType.YesNoCancel{
            # Here we have to create the cancel Button and place it on the form
            # no break
        }
        
        $QuestionType.YesNo{
           # we create Yes- and No-buttons and place it on the form
            break
        }
        
        $QuestionType.OKCancel{
            # We create OK- and Cancel-Button and place it on the form
            break
        }
    }
    
    $btn.Location = New-Object System.Drawing.Point(10, 30)
    $btn.Add_Click({
      # $Asking.DialogResult = System.Windows.Forms.DialogResult.OK
    })
    
    
    
    $Asking.Controls.Add($btn)
    $Asking.Controls.Add($lbl)
    $Asking.ShowDialog()
    If ($Asking.DialogResult = System.Windows.Forms.DialogResult.OK) {
      return True
    } else {
      return False
    }
}
