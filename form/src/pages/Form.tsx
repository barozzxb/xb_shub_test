import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { toast } from "react-toastify";

const schema = z.object({
  time: z.string().nonempty("Thời gian không được để trống"),
  quantity: z.number().min(1, "Số lượng phải > 0"),
  pump: z.string().nonempty("Trụ không được để trống"),
  revenue: z.number().min(1, "Doanh thu phải > 0"),
  price: z.number().min(1, "Đơn giá phải > 0"),
});

type FormData = z.infer<typeof schema>;

const Form = () => {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<z.infer<typeof schema>, any, z.output<typeof schema>>({
    resolver: zodResolver(schema),
  });

  const onSubmit = (data: FormData) => {
    console.log(data);
    toast.success("Giao dịch đã được cập nhật!");
  };

  return (
    <div className="w-full max-w-md mx-auto mt-10 p-6 border border-gray-300 rounded-lg shadow-md">
      <form className="flex flex-col items-start mb-6" onSubmit={handleSubmit(onSubmit)}>
        <p className="text-sm text-gray-500 mb-1"><strong>&larr;</strong> &ensp; Đóng</p>

        <div className="flex items-center justify-between w-full mb-4">
          <h1 className="text-2xl font-bold text-gray-800">Nhập giao dịch</h1>
          <input
            type="submit"
            className="bg-blue-500 text-white px-4 py-2 rounded-xl float-right"
            value="Cập nhật"
          />
        </div>

        <div className="w-full mt-6 space-y-4">
          <div className="relative">
            <label
              htmlFor="time"
              className="absolute left-3 top-1 text-xs text-gray-500"
            >
              Thời gian
            </label>
            <input
              type="datetime-local"
              id="time"
              step={1}
              {...register("time")}
              className={`w-full rounded-md border border-gray-300 px-3 pt-6 pb-2 text-sm text-gray-900 
                       focus:border-blue-500 focus:ring-1 focus:ring-blue-500 focus:outline-none
                      ${errors.time ? "border-red-500" : ""}`}
            />
            {errors.time && (
              <p className="mt-1 text-xs text-red-500">{errors.time.message}</p>
            )}
          </div>

          <div className="relative">
            <label
              htmlFor="quantity"
              className="absolute left-3 top-1 text-xs text-gray-500"
            >
              Số lượng
            </label>
            <input
              type="number"
              id="quantity"
              step={0.01}
              {...register("quantity", { valueAsNumber: true })}
              className={`w-full rounded-md border border-gray-300 px-3 pt-6 pb-2 text-sm text-gray-900 
                       focus:border-blue-500 focus:ring-1 focus:ring-blue-500 focus:outline-none
                      ${errors.quantity ? "border-red-500" : ""}`}
            />
            {errors.quantity && (
              <p className="mt-1 text-xs text-red-500">{errors.quantity.message}</p>
            )}
          </div>

          <div className="relative">
            <label
              htmlFor="pump"
              className="absolute left-3 top-1 text-xs text-gray-500"
            >
              Trụ
            </label>
            <select
              id="pump"
              {...register("pump")}
              className={`w-full rounded-md border border-gray-300 px-3 pt-6 pb-2 text-sm text-gray-900 
                       focus:border-blue-500 focus:ring-1 focus:ring-blue-500 focus:outline-none
                      ${errors.pump ? "border-red-500" : ""}`}
            >
              <option value="" disabled selected hidden>
              </option>
              <option value="1">Trụ 1</option>
              <option value="2">Trụ 2</option>
              <option value="3">Trụ 3</option>
            </select>
            {errors.pump && (
              <p className="mt-1 text-xs text-red-500">{errors.pump.message}</p>
            )}
          </div>

          <div className="relative">
            <label
              htmlFor="revenue"
              className="absolute left-3 top-1 text-xs text-gray-500"
            >
              Doanh thu
            </label>
            <input
              type="number"
              id="revenue"
              {...register("revenue", { valueAsNumber: true })}
              className={`w-full rounded-md border border-gray-300 px-3 pt-6 pb-2 text-sm text-gray-900 
                       focus:border-blue-500 focus:ring-1 focus:ring-blue-500 focus:outline-none
                      ${errors.revenue ? "border-red-500" : ""}`}
            />
            {errors.revenue && (
              <p className="mt-1 text-xs text-red-500">{errors.revenue.message}</p>
            )}
          </div>

          <div className="relative">
            <label
              htmlFor="price"
              className="absolute left-3 top-1 text-xs text-gray-500"
            >
              Đơn giá
            </label>
            <input
              type="number"
              id="price"
              {...register("price", { valueAsNumber: true })}
              className={`w-full rounded-md border border-gray-300 px-3 pt-6 pb-2 text-sm text-gray-900 
                       focus:border-blue-500 focus:ring-1 focus:ring-blue-500 focus:outline-none
                      ${errors.price ? "border-red-500" : ""}`}
            />
            {errors.price && (
              <p className="mt-1 text-xs text-red-500">{errors.price.message}</p>
            )}
          </div>
        </div>
      </form>
    </div>
  );
};

export default Form;