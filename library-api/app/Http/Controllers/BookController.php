<?php

namespace App\Http\Controllers;

use App\Book;
use Illuminate\Http\Request;

class BookController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {

    }

    /**
     * Get latest book data
     *
     * @return array
     */
    public function getLatest() {
        try {
            $maxData = request()->input('take', 4);
            $data = Book::orderBy('created_at', 'desc')
                     ->take($maxData)
                     ->get();

            return response()->json([
                'status' => 'success',
                'message'=> 'Success',
                'data'   => $data
            ], 200);
        } catch (\Exception $ex) {
            return response()->json([
                'status' => 'error',
                'message'=> 'Error',
                'errors' => $ex->getMessage()
            ], 400);
        }
    }


    /**
     * Get all book data list
     *
     * @return array
     */
    public function getAll() {
        try {
            $searchText = strtolower(request()->input('search', ''));
            $maxData = request()->input('take', 10);
            $data = Book::where('isbn', 'ILIKE', "%$searchText%")
                     ->orWhere('title', 'ILIKE', "%$searchText%")
                     ->orWhere('author', 'ILIKE', "%$searchText%")
                     ->orWhere('genre', 'ILIKE', "%$searchText%")
                     ->orderBy('created_at', 'asc')
                     ->paginate($maxData);

            return response()->json([
                'status' => 'success',
                'message'=> 'Success',
                'data'   => $data
            ], 200);
        } catch (\Exception $ex) {
            return response()->json([
                'status' => 'error',
                'message'=> 'Error',
                'errors' => $ex->getMessage()
            ], 400);
        }
    }

    /**
     * Get single book data
     *
     * @return array
     */
    public function get(Request $request, $id) {
        try {
            $data = Book::where('id', $id)->first();

            return response()->json([
                'status' => 'success',
                'message'=> 'Success',
                'data'   => $data
            ], 200);
        } catch (\Exception $ex) {
            return response()->json([
                'status' => 'error',
                'message'=> 'Error',
                'errors' => $ex->getMessage()
            ], 400);
        }
    }

    /**
     * Create a new book data
     *
     * @param Request $request
     * @return array
     */
    public function create(Request $request)
    {
        try {
            $validatedRequest = $this->validate($request, [
                'title'             => 'required|max:100',
                'author'            => 'required|max:50',
                'publisher_name'    => 'required|max:50',
                'publisher_year'    => 'required|max:50',
                'genre'             => 'required|max:50',
                'synopsis'          => 'required|max:200',
                'status'            => 'required'
            ]);

            $validatedRequest['isbn'] = $this->generateISBNString();

            Book::create($validatedRequest);

            return response()->json([
                'status' => 'success',
                'message'=> 'Book has been successfully created.'
            ], 200);
        } catch (\Exception  $ex) {
            return response()->json([
                'status' => 'error',
                'message'=> 'Error',
                'errors' => $ex->getMessage()
            ], 400);
        }
    }

    /**
     * Update existing book data
     *
     * @param Request $request
     * @return array
     */
    public function update(Request $request, $id)
    {
        try {
            $validatedRequest = $this->validate($request, [
                'id'                => 'required|exists:books,id',
                'title'             => 'required|max:100',
                'author'            => 'required|max:50',
                'publisher_name'    => 'required|max:50',
                'publisher_year'    => 'required|max:50',
                'genre'             => 'required|max:50',
                'synopsis'          => 'required|max:200',
                'status'            => 'required'
            ]);

            $data = Book::find($id);
            $data->fill($validatedRequest);
            $data->save();

            return response()->json([
                'status' => 'success',
                'message'=> 'Book has been successfully updated.'
            ], 200);
        } catch (\Exception $ex) {
            return response()->json([
                'status' => 'error',
                'message'=> 'Error',
                'errors' => $ex->getMessage()
            ], 400);
        }
    }

    /**
     * Delete existing book data
     *
     * @param Request $request
     * @return array
     */
    public function delete(Request $request, $id)
    {
        try {
            // $validatedRequest = $this->validate($request, [
            //     'id'  => 'required|exists:books,id',
            // ]);
            $data = Book::find($id);
            $data->delete();

            return response()->json([
                'status' => 'success',
                'message'=> 'Book has been successfully deleted.'
            ], 200);
        } catch (\Exception $ex) {
            return response()->json([
                'status' => 'error',
                'message'=> 'Error',
                'errors' => $ex->getMessage()
            ], 400);
        }

    }

    private function generateRandomString(int $length = 10)
    {
        $characters = '0123456789';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }

    private function generateISBNString()
    {
        $faker = \Faker\Factory::create();
        $faker->addProvider(new \Faker\Provider\Barcode($faker));
        return $faker->isbn13;
    }
}
