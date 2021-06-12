defmodule LeTrollSupervisor do
  @moduledoc false

  def start(_target, _args) do

    import Supervisor.Spec

    children = [
      worker(LeTrollConsumer, [], id: 1),
      worker(Cachex, [:letroll_cache, []])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

  end


end
