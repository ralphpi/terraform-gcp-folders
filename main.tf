# Top-level folder under an organization.

data "google_active_folder" "new_active_parent" {
  display_name = "${element(var.parent_folder_name  , 0)}"
  parent = "${var.parent_id}"  
}

resource "google_folder" "parent_folder_creation" {
  count = "${length(var.folder_name)}"
  display_name = "${element(var.folder_name, count.index)}"
  parent = "${data.google_active_folder.new_active_parent.name}"
  depends_on = ["data.google_active_folder.new_active_parent"]
}

#Second Level AKA Child  

data "google_active_folder" "new_active_parent2" {
  display_name = "${element(var.parent_folder_name  , 0)}"
  parent = "${var.parent_id}"  
}


# Destroy Limitations: You must Destroy in order from right to left of childlist Array
resource "google_folder" "child_folder_creation" {
  count= "${length(var.childlist)}"
  #display_name = "${element(var.children, count.index)}"
  display_name = "${lookup(var.childlist[count.index], "child")}"
  parent = "${element(google_folder.parent_folder_creation.name, 0)}"
  #parent = "${[element(google_folder.parent_folder_creation.*.id, count.index)}"
  
  
}

