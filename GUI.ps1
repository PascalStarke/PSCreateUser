# GUI.ps1
# Basic GUI functions

Add-Type -AssemblyName System.Windows.Forms

$QuestionType = New-Object psobject -property @{
    YesNo = 0
    OkCancel = 1
    YesNoCancel = 2
    OkOnly = 3
}

# Ask a question. Show a standard question dialog with choosable buttons (similiar to MsgBox)
function Ask($Question, $Header, $PossibleAnswers) {
    $Asking = New-Object System.Windows.Forms.Form -property @{
        Text = $Header
        Size = New-Object System.Drawing.Size(420, 180)
        StartPosition = "CenterScreen"
    }
    
    $lbl = New-Object System.windows.Forms.Label -property @{
        Text = $Question
    }
    
    $btnYes = New-Object System.windows.Forms.Button -property @{
        Text = "&Ja"
        Location = New-Object System.Drawing.Point(129, 110)
        Size = New-Object System.Drawing.Size(75, 23)
        TabIndex = 1
    }
    $btnNo = New-Object System.windows.Forms.Button -property @{
        Text = "&Nein"
        Location = New-Object System.Drawing.Point(210, 110)
        Size = New-Object System.Drawing.Size(75, 23)
        TabIndex = 2
    }
    $btnCancel = New-Object System.windows.Forms.Button -property @{
        Text = "&Abbrechen"
        Location = New-Object System.Drawing.Point(291, 110)
        Size = New-Object System.Drawing.Size(75, 23)
        TabIndex = 3
    }
    
    Switch($PossibleAnswers) {
        $QuestionType.YesNoCancel{
            $Asking.Controls.Add($btnCancel)
        }
        
        $QuestionType.YesNo{
           $Asking.Controls.Add($btnYes)
           $Asking.Controls.Add($btnNo)
           $btnYes.Add_Click({
                $Asking.DialogResult = [System.Windows.Forms.DialogResult]::Yes
            })
            break
        }
        
        $QuestionType.OKCancel{
            $Asking.Controls.Add($btnYes)
            $Asking.Controls.Add($btnCancel)
            $btnYes.Text = "OK"
            $btnYes.Position = $btnNo.Position
            $btnYes.Add_Click({
                $Asking.DialogResult = [System.Windows.Forms.DialogResult]::OK
            })
            break
        }
    }
    
    
    $btnNo.Add_Click({
      $Asking.DialogResult = [System.Windows.Forms.DialogResult]::No
    })
    $btnCancel.Add_Click({
      $Asking.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    })
    
    $Asking.Controls.Add($btn)
    $Asking.Controls.Add($lbl)
    
    return $Asking.ShowDialog()
}
