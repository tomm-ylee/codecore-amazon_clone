class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new
    if user.is_admin?
      can :manage, :all
    end

    can :crud, Product do |product|
      product.user == user
    end

    can :favourite, Product do |product|
      product.user != user
    end

    can :destroy, Favourite do |favourite|
      favourite.user == user
    end

    can :crud, Review do |review|
      review.user == user
    end

    can :like, Review do |review|
      review.user != user
    end

    can :destroy, Like do |like|
      like.user == user
    end

    can :manage, NewsArticle do |news_article|
      news_article.user == user
    end

  end
end
