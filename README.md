This is a script to make this easier to export items from cryptics game engine editors to share or backup more efficiently 

simply in the game when using the editors to make and item hit the export csv option save it into a folder called EXPORTS name the csv something you will remember what the item is for example "power drink.csv" 

then edit the export.bat to have your locations in there.

i was using a remote dev client in H: drive when the samba share was on the server on the W: mount 

so you set the following:
`set "csv_dir=H:\NEVERWINTER\NEVERWINTER\Night\data\EXPORTS"
`
to where you have your dev client files on your dev client pc

then you set the following:
`set "base_dir=W:\Night\data"`
to where you have your remote server files stored 

note if you are using the same pc you will still need to locate the EXPORTS dir and the data dir seperately 

once done put the bat file in the EXPORTS folder and then you can double click to run the bat and export your content and it will make the folders needed and copy the files you exported out so you can simply just drop them into another install data folder to use 


