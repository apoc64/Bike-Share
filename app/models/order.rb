class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user
  has_many :accessory_orders

  has_many :accessories, through: :accessory_orders

  enum status: [:ordered, :completed, :paid, :cancelled]

  def cost
    accessory_orders.reduce(0) do |sum, ao|
      sum + ao.quantity * ao.accessory.price
    end
  end

  def self.total_ordered
    where(status: 'ordered').count
  end

  def self.total_paid
    where(status: 'paid').count
  end

  def self.total_cancelled
    where(status: 'cancelled').count
  end
  def self.total_completed
    where(status: 'completed').count
  end
end
