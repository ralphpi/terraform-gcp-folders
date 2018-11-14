# Top-level folder under an organization.
resource "google_folder" "parent_folder_creation" {
  #count = "${length(var.folder_name)}"
  display_name = "${var.folder_name}"
  parent = "folders/${var.parent_folder_id}"
}

#Second Level AKA Child  
# Destroy Limitations: You must Destroy in order from right to left of childlist Array
resource "google_folder" "child_folder_creation" {
  count= "${length(var.childlist)}"
  #display_name = "${element(var.children, count.index)}"
  display_name = "${lookup(var.childlist[count.index], "child")}"
  parent = "${element(google_folder.parent_folder_creation.*.id, count.index)}"
  
}