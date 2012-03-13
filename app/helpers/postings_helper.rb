# encoding: utf-8
module PostingsHelper

  def posting_type_to_text(posting)
    case posting.type
    when 'ParticipationPosting'
      case posting.expense.type
      when 'Training'
        'tréning'
      when 'Tournament'
        'turnaj'
      else # 'OtherExpense'
        '-' # TODO
      end
    when 'ExpensePosting'
      'expense posting' # TODO
    when 'UserPosting'
      'user posting' # TODO
    else
      '-'
    end
  end

  def number_to_price(num)
    num = 0 if num.nil?
    content_tag(:span, number_to_currency(num),:class => "c-#{price_to_color(num)}")
  end

  def price_to_color(num)
    if num < 0
      'red'
    elsif num == 0
      'gray'
    else
      'green'
    end
  end

  def posting_detail_to_text(posting)
    case posting.type
    when 'ParticipationPosting'
      case posting.expense.type
      when 'Training'
        link_to posting.expense.name, training_path(posting.expense)
        #a += content_tag(:span, " [#{posting.expense.start_at.strftime('%d.%m.%Y')}]", class: 'c-gray')
      when 'Tournament'
        link_to posting.expense.name, tournament_path(posting.expense)
      when 'OtherExpense'
        link_to posting.expense.name, other_expense_path(posting.expense)
      else
        'ParticipationPosting: TODO' # TODO
      end
    when 'ExpensePosting'
      'ExpensePosting: TODO' # TODO
    when 'UserPosting'
      'UserPosting: TODO' # TODO
    else
      '-'
    end
  end

end
