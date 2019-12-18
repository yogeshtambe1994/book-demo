class AuthorsController < ApplicationController
	
	def index
		@authors = Author.all
		respond_to do |format|
    	format.html  # index.html.erb
    	format.json  { render :json => @authors }
    	format.xml { render xml: @authors }
  	end
	end

	def new
		@author = Author.new
	end

	def edit
  	@author = Author.find(params[:id])
	end

	def create
		@author = Author.new(author_params)
		binding.pry
		# @author.books << Book.find(params[:author][:book_ids])
		if @author.save
			redirect_to @author
		else
			render 'new'
		end
	end

	def update
  	@author = Author.find(params[:id])
  	if @author.update(author_params)
   	 redirect_to @author
 		else
    	render 'edit'
  	end
	end

	def show
    @author = Author.find(params[:id]).to_json(only: [:first_name, :last_name], :include => :books)
		respond_to do |format|
    	format.html  # index.html.erb
    	format.json  { render :json => @author }
  	end
  end

  def destroy
  	@author = Author.find(params[:id])
  	@author.destroy
	  redirect_to authors_path
	end

	private
		def author_params
    	params.require(:author).permit(:first_name, :last_name, :date_of_birth)
  	end
end
