deploy: update_post_readme hugo commit

update_post_readme:
	ruby chief.rb 

hugo:
	hugo -t hugo-cards

commit:
	./deploy
