class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy reserve unreserve pay unpay ]
  before_action :authenticate_user!

  # GET /books or /books.json
  def index
    @books = Book.all
    @books.each do |b|
      b.unreserved! if b.reserved?
    end
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  def reserve
    if @book.unreserved?
      @book.reserved!
      @book.user = current_user
    end
    
    respond_to do |format|
      if @book.save
        format.js
      end
    end
  end

  def unreserve
    if @book.user == current_user
      if @book.reserved?
        @book.unreserved!
        @book.user = nil
      end
      
      respond_to do |format|
        if @book.save
          format.js
        end
      end
    end
  end

  def pay
    if @book.user == current_user
      @book.paid!

      respond_to do |format|
        if @book.save
          format.js
        end
      end
    end
  end

  def unpay
    if @book.user == current_user
      @book.unreserved!

      respond_to do |format|
        if @book.save
          format.js
        end
      end
    end
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :user_id, :state)
    end
end
