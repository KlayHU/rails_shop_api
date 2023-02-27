module Paginable

  # 同为index方法服务，因此需要把公共代码提取出来维护。
  # 首先 由于这是在控制器内使用的代码，所以我们遵循通常的约定：把控制器的通用代码放到控制器所在目录的concerns目录下面，
  # 我们可以创建一个和分页相关名称的文件存放代码。
  # 然后 在application_controller.rb文件中提供所有控制器使用
  protected
  def _to_i(param, default_no = 1)
    param && param.to_i > 0 ? param.to_i : default_no.to_i
  end

  def set_page
    @page = _to_i(params[:page], 1)
    @page = set_per_page * (@page -1)
  end

  def set_per_page
    @per_page = _to_i(params[:per_page], 10)
  end

end