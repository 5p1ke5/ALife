/// @description Destroys self, adds item to inventory, creates message telling player that happened.
instance_destroy();

inventory_add(other.inventory, item);

print(string(ds_list_write(other.inventory)));