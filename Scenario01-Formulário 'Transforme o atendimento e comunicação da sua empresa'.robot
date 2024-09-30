** Settings **
Library  SeleniumLibrary
Library  FakerLibrary    locale=pt_BR

** Variables **
${BASE_URL}    https://smartspace.com.br/     

${input_name_by_id_prefix}       css=[id^='rd-nome_field-']
${input_email_by_id_prefix}      css=[id^='rd-email_field-']
${input_phone_by_id_prefix}      css=[id^='rd-phone_field-'] 
${select_estado_by_id_prefix}    css=[id^='rd-select_field-']
${input_empresa_by_id}           id=rd-text_field-lza3jr5t
${input_cargo_by_id}             id=rd-text_field-lza3jr5u
${click_button_by_prefix}        css=[id^='rd-button-']

** Keywords **
Abrir portal SmartSpace
    Open Browser                  ${BASE_URL}                       chrome
Preencher campo nome
    Sleep    3s
    Input Text                    ${input_name_by_id_prefix}        ''
Preencher campo email
    Sleep    3s
    ${email}    FakerLibrary.Email
    Input Text                    ${input_email_by_id_prefix}       ${email}
Preencher campo phone
    Sleep    3s
    Input Text                    ${input_phone_by_id_prefix}       99999999999
Selecionar item estado
    Sleep    3s
    Select From List By Value     ${select_estado_by_id_prefix}     PB
Preencher campo empresa
    Sleep    3s
    ${empresa}    FakerLibrary.Company
    Input Text                    ${input_empresa_by_id}            ${empresa}
Preencher campo cargo
    Sleep    3s
    ${cargo}    FakerLibrary.Job
    Input Text                    ${input_cargo_by_id}              ${cargo}
Clicar botão enviar
    Sleep    3s
    Click Button                  ${click_button_by_prefix}
Visualizar mensagem de nome obrigatório
    ${mensagem}=                  Get Text       css=div.bricks-form__field:nth-child(1) > label:nth-child(3)
    Should Be Equal As Strings    ${mensagem}    Campo obrigatório

** Test Cases **
Case01: Validar obrigatoriedade do campo 'nome' do formulário 'Transforme o atendimento e comunicação da sua empresa'
    Given Abrir portal SmartSpace
    When Preencher campo email
        And Preencher campo phone
        And Selecionar item estado
        And Preencher campo empresa
        And Preencher campo cargo
        And Clicar botão enviar
            Wait Until Element Is Visible    css=div.bricks-form__field:nth-child(1) > label:nth-child(3)   timeout=1s
    Then Visualizar mensagem de nome obrigatório