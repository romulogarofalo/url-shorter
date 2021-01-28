defmodule UrlshorterTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = Urlshorter.start_link()
    {:ok, pid: pid}
  end

  describe "tests genserver of url shorter" do
    test "short url", %{pid: pid} do
      assert {:ok, url_shorted} = Urlshorter.shortem(pid, "www.test.com")
    end

    test "get url shorted", %{pid: pid} do
      {:ok, url_shorted} = Urlshorter.shortem(pid, "www.test.com")

      assert {:ok, "www.test.com"} == Urlshorter.url(pid, url_shorted)
    end
  end
end
