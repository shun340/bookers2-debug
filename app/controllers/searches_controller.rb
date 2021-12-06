class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content).or(User.where(introduction: content))
      elsif method == 'forward'
        User.where('name LIKE ? OR introduction LIKE ?', "#{content}%", "#{content}%")
      elsif method == 'backward'
        User.where('name LIKE ? OR introduction LIKE ?', "%#{content}", "%#{content}")
      else
        User.where('name LIKE ? OR introduction LIKE ?', "%#{content}%", "%#{content}%")
      end
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content).or(User.where(body: content))
      elsif method == 'forward'
        Book.where('title LIKE ? OR body LIKE ?', "#{content}%", "#{content}%")
      elsif method == 'backward'
        Book.where('title LIKE ? OR body LIKE ?', "%#{content}", "%#{content}")
      else
        Book.where('title LIKE ? OR body LIKE ?', "%#{content}%", "%#{content}%")
      end
    end
  end
end
