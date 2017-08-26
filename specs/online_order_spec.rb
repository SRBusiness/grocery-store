require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'
require 'pry'
require_relative '../lib/online_order'
require_relative '../lib/customer'
# TODO: uncomment the next line once you start wave 3
# require_relative '../lib/online_order'
# You may also need to require other classes here

# Because an OnlineOrder is a kind of Order, and we've
# already tested a bunch of functionality on Order,
# we effectively get all that testing for free! Here we'll
# only test things that are different.
describe "OnlineOrder" do
  before do
    @online_order_one = Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"complete")
    @online_order_two = Grocery::OnlineOrder.new(2,{}, 26,"pending")
    @customer_first = Grocery::Customer.new(25, "leonard.rogahn@hagenes.org", {address1: "71596 Eden Route" , city: "Connellymouth" , state: "LA", zip_code: "98872-9105" })
  end
  describe "#initialize" do
    it "Is a kind of Order" do
      @online_order_one.must_be_kind_of Grocery::Order
    end

    it "Can access Customer object" do
      @online_order_one.customer_id.must_equal @customer_first.customer_id
    end

    it "Can access the online order status" do
      @online_order_one.must_respond_to :status
    end
  end

  describe "#total" do
    it "Adds a shipping fee" do
      @online_order_one.total.must_equal 180.68
    end

    it "Doesn't add a shipping fee if there are no products" do
      @online_order_two.total.must_equal 0
    end
  end

  describe "#add_product" do
    it "Does not permit action for processing, shipped or completed statuses" do
      proc{Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"processing").add_product("Macadamia Nut",79.19)}.must_raise ArgumentError

      proc{Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"shipped").add_product("Macadamia Nut",79.19)}.must_raise ArgumentError

      proc{Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"complete").add_product("Macadamia Nut",79.19)}.must_raise ArgumentError
    end

    it "Permits action for pending and paid satuses" do
      #double check this stuff
      # original = @online_order_one.products.length

      @online_order_two.add_product("Macadamia Nut",79.19)
      after = @online_order_two.products.length
      after.must_equal 1


      after = Grocery::OnlineOrder.new(1,{"Lobster" =>17.18, "Annatto seed" => 58.38, "Camomile" =>83.21}, 25,"paid")

      after.add_product("Macadamia Nut",79.19)
      after.products.length.must_equal 4
    end
  end

  xdescribe "OnlineOrder.all" do
    it "Returns an array of all online orders" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - OnlineOrder.all returns an array
      #   - Everything in the array is an Order
      #   - The number of orders is correct
      #   - The customer is present
      #   - The status is present
      # Feel free to split this into multiple tests if needed
    end
  end

  xdescribe "OnlineOrder.find_by_customer" do
    it "Returns an array of online orders for a specific customer ID" do
      # TODO: Your test code here!
    end
  end
end
