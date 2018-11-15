# Top-level folder under an organization.

data "google_active_folder" "new_active_parent" {
  display_name = "${var.parent_folder_name}"
  parent = "${var.parent_id}"  
}

resource "google_folder" "parent_folder_creation" {
  count = "1"
  display_name = "${var.folder_name}"
  parent = "${data.google_active_folder.new_active_parent.name}"
}

#Second Level AKA Child  


# Destroy Limitations: You must Destroy in order from right to left of childlist Array
resource "google_folder" "child_folder_creation" {
  count= "${length(var.childlist)}"
  #display_name = "${element(var.children, count.index)}"
  display_name = "${lookup(var.childlist[count.index], "child")}"
  parent = "${google_folder.parent_folder_creation.name}"
  #parent = "${element(google_folder.parent_folder_creation.name, 0)}"
  #parent = "${[element(google_folder.parent_folder_creation.*.id, count.index)}"
  depends_on = ["google_folder.parent_folder_creation"]
  
  
}



