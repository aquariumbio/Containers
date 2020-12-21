# typed: false
# frozen_string_literal: true

# This is a default, one-size-fits all protocol that shows how you can
# access the inputs and outputs of the operations associated with a job.
# Add specific instructions for this protocol!

needs 'Container/ItemContainer'
needs 'Container/KitHelper'

class Protocol
  include KitHelper

  def main
    item = Item.find(52505)

    ite_cont = ItemContainer.new(item, starting_volume: {units: 'ul', qty: 33})

    show do
      title 'The Current Volume is'
      note "Item: #{ite_cont.item}, volume: #{ite_cont.current_volume}"
    end

    ite_cont.remove_volume({ units: 'ul', qty: 22 })

    show do
      title 'The Current Volume is'
      note "Item: #{ite_cont.item}, volume: #{ite_cont.current_volume}"
    end

    ite_cont.add_volume({ units: 'ul', qty: 100 })

    show do
      title 'The Current Volume is'
      note "Item: #{ite_cont.item}, volume: #{ite_cont.current_volume}"
      note "Time last modified: #{ite_cont.date_last_modified}"
    end
    
    kit_item = Item.find(52510)
    
    kit_cont = KitContainer.new(kit_item)
    
    show do
      title "The kit parst are"
      note "consumabes"
      note kit_cont.consumables.to_s
      note "Components"
      note kit_cont.components.to_s
      note kit_cont.components.first[:input_name]
    end
    
    found_kit = find_kit(kit_item.sample.name, { qty: 22, units: 'rxn' })
    
    show do
      title 'Lets find a kit with enough volume'
      note "We found kit with item id: #{found_kit.item.id}"
      note found_kit.to_s
    end
    

  end

end
