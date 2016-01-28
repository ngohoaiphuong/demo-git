data = [
  {
    first_name: 'Luca',
    last_name: 'Poidomani',
    phone: '3336505354',
    email: 'superpoido@hotmail.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Luca',
    last_name: 'Poidomani',
    phone: '3336505354',
    email: 'superpoido@hotmail.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Luca',
    last_name: 'Poidomani',
    phone: '3336505354',
    email: 'superpoido@hotmail.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Luca',
    last_name: 'Poidomani',
    phone: '3336505354',
    email: 'superpoido@hotmail.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Giuseppe',
    last_name: 'Giosa',
    phone: '3478153512',
    email: 'haged83@gmail.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {

    first_name: 'Daniele',
    last_name: 'Gagliano',
    phone: '3288373432',
    email: 'daniele.gagliano@libero.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 0,
      why_not: 'Sistema operativo Windows'
    }
  },
  {
    first_name: 'Claudio',
    last_name: 'Giordani',
    phone: '3394249482',
    email: 'claud_gio1@yahoo.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Fabio',
    last_name: 'Battaglia',
    phone: '3779421125',
    email: 'fabiobattaglia82@gmail.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Fabio',
    last_name: 'Tammaro',
    phone: '3409661036',
    email: 'Fabio-tammaro@libero.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Elisabetta',
    last_name: 'Vita Nauta',
    phone: '3490968029',
    email: 'sbetty81@gmail.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Giuliano',
    last_name: 'Lo Buono',
    phone: '3282776358',
    email: 'giuliano.lobuono@yahoo.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Vincenzo',
    last_name: 'Ingrao',
    phone: '3392897229',
    email: 'ingrao.vincenzo@gmail.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Lucrezia',
    last_name: 'Sacchi',
    phone: '3285347020',
    email: 'Lucrezia.sacchi@aol.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Sara',
    last_name: 'Pesci',
    phone: '3405543002',
    email: 'sara.pesci@gmail.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Matteo',
    last_name: 'Origgi',
    phone: '3496120510',
    email: 'super_aggio@hotmail.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },
  {
    first_name: 'Paolo',
    last_name: 'Gioia',
    phone: '3282882882',
    email: 'paologioia87@gmail.com',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  },  
  {
    first_name: 'Micol',
    last_name: 'Frigerio',
    phone: '3341061382',
    email: 'm.frigerio42@campus.unimib.it',
    created_at: '2015-09-24',
    employee: 797,
    questions: {
      disclaimer: 1
    }
  }
]

campaign = Campaign.find(20)
workflow = campaign.workflows.find(3)
workflow_action = workflow.workflow_actions.first
questionnaire_action = Workflow::QuestionnaireAction.where(workflow_id: workflow.id).first
questionnaire = questionnaire_action.questionnaire

shop_assistant = 797
shop_assistant = 627
timestamp = '18:00:00'

employee_workflow = workflow.employee_workflows.where(employee_id: shop_assistant).first

if employee_workflow.present?
  data.each do |item|
    # create respondent
    respondent = employee_workflow.respondents.new(
      first_name: item[:first_name],
      last_name: item[:last_name],
      phone: item[:phone],
      email: item[:email]
      )
    respondent.save

    # create respondent_action
    respondent_action = respondent.respondent_actions.new(workflow_action_id: workflow_action.id)
    respondent_action.save
    respondent_action.update_attributes(
      :start_on => "#{item[:created_at]} #{timestamp}", 
      :end_on => "#{item[:created_at]} #{timestamp}"
      )

    interview = questionnaire.interviews.new(
      questionnaire_id: questionnaire.id,
      employee_id: shop_assistant, 
      respondent_action_id: respondent_action.id, 
      client_interview_id: "#{respondent_action.id}-#{SecureRandom.uuid}".upcase()
      )
    interview.save
    interview.update_attributes(
      :created_at => "#{item[:created_at]} #{timestamp}", 
      :updated_at => "#{item[:created_at]} #{timestamp}"
      )

    if item[:questions][:disclaimer].to_i == 1
      interview.answers.new(
        option_id: interview.questionnaire.options.where(value: 1, open_answer: false).first.id
        ).save
    elsif item[:questions][:disclaimer].to_i == 0 
      interview.answers.new(
        option_id: interview.questionnaire.options.where(value: 0).first.id
        ).save

      interview.answers.new(
        option_id: interview.questionnaire.options.where(value: 1, open_answer: true).first.id, 
        open_answer: item[:questions][:why_not]
        ).save
    end
  end
else
  p "Can't found shop assistant #{shop_assistant}"
end