# GUI.ps1
# Basic GUI functions
# Take a look at https://gist.github.com/Clijsters/fc5cbc560071a2a0e9d6
# PSCreateUser - Educational project

# Load Assemblies
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
# CmdLet-Way: Add-Type -AssemblyName System.Windows.Forms

$QuestionType = New-Object psobject -property @{
    YesNo = 0
    OkCancel = 1
    YesNoCancel = 2
#   OkOnly = 3
}

# Ask a question. Show a standard question dialog with choosable buttons (similiar to MsgBox)
#TODO: Change representation of parameter list
function Ask($Question, $Header, $PossibleAnswers) {
    # Create a new Form
    $Asking = New-Object System.Windows.Forms.Form -property @{
        Text = $Header
        Size = New-Object System.Drawing.Size(384, 173)
        StartPosition = "CenterScreen"
        MaximizeBox = 0
        MinimizeBox = 0
        TopMost = 1
        FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    }
    
    # Create a new Label
    $lbl = New-Object System.windows.Forms.Label -property @{
        Text = $Question
        Size = New-Object System.Drawing.Size(200, 105)
        Location = New-Object System.Drawing.Point(5, 3)
    }
    
    # Create a new Button (Yes and OK)
    $btnYes = New-Object System.windows.Forms.Button -property @{
        Text = "&Ja"
        Location = New-Object System.Drawing.Point(129, 115)
        Size = New-Object System.Drawing.Size(75, 23)
        TabIndex = 1
    }
    
    # Create a new Button (No)
    $btnNo = New-Object System.windows.Forms.Button -property @{
        Text = "&Nein"
        Location = New-Object System.Drawing.Point(210, 115)
        Size = New-Object System.Drawing.Size(75, 23)
        TabIndex = 2
    }
    
    # Create a new Button (Cancel)
    $btnCancel = New-Object System.windows.Forms.Button -property @{
        Text = "&Abbrechen"
        Location = New-Object System.Drawing.Point(291, 115)
        Size = New-Object System.Drawing.Size(75, 23)
        TabIndex = 3
    }
    
    # positioning the buttons
    #TODO: make it a if-statement - YesNoCancel and YesNo redundancy
    Switch($PossibleAnswers) {
        $QuestionType.YesNoCancel {
            $Asking.Controls.Add($btnNo)
            $Asking.Controls.Add($btnCancel)
            # Add Event Listener for Click event on $btnYes
            $btnYes.Add_Click({
                $Asking.DialogResult = [System.Windows.Forms.DialogResult]::Yes
            })
        }
        
        $QuestionType.YesNo {
            $btnYes.Location = $btnNo.Location
            $btnNo.Location = $btnCancel.Location
            $Asking.Controls.Add($btnNo)
            # Add Event Listener for Click event on $btnYes
            $btnYes.Add_Click({
                $Asking.DialogResult = [System.Windows.Forms.DialogResult]::Yes
            })
            
        }
        
        $QuestionType.OKCancel {
            $Asking.Controls.Add($btnCancel)
            $btnYes.Text = "OK"
            $btnYes.Location = $btnNo.Location
            # Add Event Listener for Click event on $btnYes (OK)
            $btnYes.Add_Click({
                $Asking.DialogResult = [System.Windows.Forms.DialogResult]::OK
            })
        }
    }
    
    # Add Event Listener for Click event on $btnNo
    $btnNo.Add_Click({
      $Asking.DialogResult = [System.Windows.Forms.DialogResult]::No
    })
    
    # Add Event Listener for Click event on $btnCancel
    $btnCancel.Add_Click({
      $Asking.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    })
    
    # Add $lbl to Form
    $Asking.Controls.Add($lbl)
    
    # Ass $btnYes to Form
    $Asking.Controls.Add($btnYes)
    
    return $Asking.ShowDialog()    
}
