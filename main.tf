# Top-level folder under an organization.

data "google_active_folder" "new_active_parent" {
  display_name = "${var.parent_folder_name}"
  parent = "${var.parent_id}"  
}

resource "google_folder" "parent_folder_creation" {
  #count = "${length(var.folder_name)}"
  #display_name = "${element(var.folder_name, count.index)}"
  display_name = "${var.folder_name}"
  parent = "${data.google_active_folder.new_active_parent.name}"
  depends_on = ["data.google_active_folder.new_active_parent"]
}

#Second Level AKA Child  


