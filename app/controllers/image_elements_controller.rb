class ImageElement < ApplicationController

    # POST /carts or /carts.json
  def create
    @image_element = ImageElement.new(image_element_params)

    
      if @image_element.save
        format.html { redirect_to @image_element, notice: "image_element was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
  end

  #time 8.05
=begin
  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    image_element = Product.image_elements.find(params[:id])
      if @image_element.update(image_element_params)
        format.html { redirect_to @image_element, notice: "ImageElement was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @image_element.destroy
    format.html { redirect_to image_elements_url, notice: "Image was successfully destroyed." }
  end
=end
end