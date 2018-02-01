class BaseAssetsController < ApplicationController
  def show
    @asset = find_asset

    @asset.unscanned? ? set_expiry(0) : set_expiry(30.minutes)
    render json: AssetPresenter.new(@asset, view_context)
  end

  def create
    @asset = build_asset

    if @asset.save
      render json: AssetPresenter.new(@asset, view_context).as_json(status: :created), status: :created
    else
      error 422, @asset.errors.full_messages
    end
  end
end
